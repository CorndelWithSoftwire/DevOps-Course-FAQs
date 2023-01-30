# Module 9 Project Exercise Hints

Are you seeing any of the below issues?

### Issues deploying to Azure

<details markdown="1">
<summary markdown="1">
Azure is trying to run my tests
</summary>

This can be an issue seen when using a provided action to build your image which isn't taking any explicit instructions for how to build your Docker image, and therefore doesn't choose any specific `target` stage. The easiest solution for this is to specify a target, but if that's not an option for your action then you could ensure the production stage is the final stage in your Dockerfile, as this will then be the default target for `docker build` commands.
</details>

<details markdown="1">
<summary markdown="1">
The `curl` command executes in my pipeline, but it's not clear it succeeded
</summary>

Your curl command should show a response that includes a link to the deployment logs for your application, something like:
```
{"OperationId":"<id>","TrackingUrl":"https://<your_app_name>.scm.azurewebsites.net/api/logstream?filter=op:<id>,volatile:false"}
```

If you don't see that, and _just_ see something more like the below then the curl command *didn't* succeed.
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100     1    0     0  100     1      0      1  0:00:01 --:--:--  0:00:01     1
```

As a first pass, adding a `--fail` flag to your curl command can be useful as otherwise curl reports success as long as a successful connection was made, even if the response reports a failure (e.g. a status code > 400) which can lead to confusing pipeline results.

However, that only makes the issue more obvious, it doesn't solve it. The most likely issue here is due to subtleties around how the webhook had the `$` escaped, particularly if you're using GitHub Actions.

Possible solutions to this include:
* If you _didn't_ escape your Webhook in your GitHub secrets, then make sure the reference to it is wrapped in single quotes so that it is interpreted precisely as is:
```
curl -dH --fail -X POST '${{ secrets.UNESCAPED_WEBHOOK }}'
```
* If you _did_ escape your Webhook in your GitHub secrets, then make sure you're using double quotes so that the escape is not interpreted as a literal `\`:
```
curl -dH -X POST '${{ secrets.ESCAPED_WEBHOOK }}'
```

Alternatively, GitHub actions will escape appropriately when converting secrets to environment variables, so one solution can be to rely on that:
```
     env:
       UNESCAPED_WEBHOOK: '${{ secrets.UNESCAPED_WEBHOOK }}'
     steps:
        ...
        - run: curl -dH --fail -X POST $UNESCAPED_WEBHOOK
```

</details>

<details markdown="1">
<summary markdown="1"> If you're using Heroku instead
</summary>

### If using Heroku: Issues deploying to Heroku

<details markdown="1">
<summary markdown="1">
Permission issues from Heroku when deploying
</summary>

Before you can push images, you need to log in to the Heroku container registry, which you can either do through Docker using an appropriate API key:
```
echo $HEROKU_API_KEY | docker login --username $HEROKU_USER --password-stdin registry.heroku.com
```
or directly through the Heroku CLI - note that this second option relies on you having set an environment variable called _precisely_ HEROKU_API_KEY with a relevant key.
```
heroku container:login
```

</details>

### Issues with app running on Heroku


<details markdown="1">
<summary markdown="1">
My app runs locally, but not in Heroku!
</summary>

First off, check the logs that Heroku provides; you can access those either [through the CLI or through the Heroku website](https://devcenter.heroku.com/articles/logging#view-logs). Do they provide any hints? 

Common things to look for are:
* Issues installing or accessing packages & libraries; Heroku sometimes struggles with Python virtual environments. In this case, there's no need for us to use a virtual environment within an isolated container, so try swapping your `RUN poetry install` step for `RUN poetry config virtualenvs.create false --local && poetry install`
* The app starts, but Heroku doesn't recognise it; if this is the case it's worth checking whether it's running on the correct port. Have you switched to use the PORT environment variable that Heroku requires, or are you still running on 80/5000?
* The entrypoint command is otherwise failing to run correctly.
  * In this case, switching to use a separate script file for your entrypoint can be the best solution. Move your startup command to e.g. `entrypoint.sh` and then COPY it into your image and invoke it from your `ENTRYPOINT` (e.g. set the executable permissions with `RUN chmod +x ./entrypoint.sh` and then call it with `ENTRYPOINT ["./entrypoint.sh"]`)
</details>

<details markdown="1">
<summary markdown="1">
Heroku is trying to run my tests
</summary>

This is a common issue seen when using a provided action like [this one](https://github.com/marketplace/actions/deploy-to-heroku) - the reason is that the action does not take any explicit instructions for how to build your Docker image, and therefore doesn't choose any specific `target` stage. The easiest solution for this is to ensure the production stage is the final stage in your Dockerfile, as this will then be the default target for `docker build` commands, but alternatively a [heroku.yml](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#targeting-a-stage-from-a-multi-stage-build) can be used to specify the target stage.
</details>

</details>