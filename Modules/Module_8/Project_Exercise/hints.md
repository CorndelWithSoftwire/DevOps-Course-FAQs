# Module 8 Project Exercise Hints

Are you seeing any of the below issues?

### Issues deploying to Heroku

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