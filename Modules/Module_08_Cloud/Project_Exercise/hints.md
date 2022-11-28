# Module 9 Project Exercise Hints

Are you seeing any of the below issues?

### App Service isn't working

<details markdown="1">
<summary markdown="1">
Deployed App Service isn't running?
</summary>

If you've set up your App Service but you just see an error page when you hit it, there are a few avenues to explore to track down potential issues:

* Is the app actually broken?
  * Check that you can build & run your production Docker image locally - you might have made a tweak that genuinely breaks it. You might find it easier to track down issues here
* Has the container image been successfully accessed from DockerHub?
  * If you visit the Azure Portal, find your App Service & open the Deployment Center, you should see a "Logs" tab that gives deployment specific logs; check that there is some evidence in those logs that your image has successfully been pulled. Errors here might suggest e.g.:
    * That your image name has a typo
    * That your image is hosted privately on DockerHub
    * That your credentials have a typo
* Are there any helpful logs for the app?
  * Again in the Azure Portal, take a look in the "Log Stream" page (*not* the "Logs" page) of the Monitoring section; you may need to be patient or hit your app a few times if the logs don't initially load, but if the app is erroring then you should see issues here.
* Check that your environment variables look correct; the "Configuration" page for your app should contain all of the necessary environment variables that you need to set in your .env file locally
* Is the port forwarding setup correctly?
  * [By default App Service expects your service to be running on port 80 or 8080](https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux#configure-port-number). This behaviour can be overridden by setting the WEBSITES_PORT app setting.
* If you don't see any of the above, it's worth checking if you're looking at the right place! Does the URL you're currently at match the URL that you app service should be hosted at? If you have completed Module 11 make sure the URL after redirecting through GitHub/GitLab is correct.

</details>
