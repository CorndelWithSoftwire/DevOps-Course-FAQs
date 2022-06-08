# Module 11 Project Exercise Hints

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
* If you don't see any of the above, it's worth checking if you're looking at the right place! Does the URL your currently at match the URL that you app service should be hosted at? If not, take a look at the hint for errors _after_ GitHub redirects have happened
</details>

<details markdown="1">
<summary markdown="1">
App Service redirects to GitHub but then errors after being redirected back?
</summary>

If you see that you're successfully redirected to GitHub (which is usually easiest to test in a private browsing session, to visibly see the redirect) but then see errors once you've been redirected back, the first culprit to check is whether you have been redirected back to the right address, so check the URL bar; does it match that for your App Service?

It's common to forget, you'll need to set up a new OAuth app for the Azure application; simply reusing existing Client ID/Client Secret values will lead to the redirect sending you to somewhere that isn't Azure.

If it is, then it sounds like a genuine error; checking that you've set the right environment variables is usually a good starting point, otherwise look at the hints for debugging a broken deployed application.
</details>