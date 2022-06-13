# Module 11 Project Exercise Hints

### App Service isn't working

<details markdown="1">
<summary markdown="1">
App Service redirects to GitHub (or GitLab) but then errors after being redirected back?
</summary>

If you see that you're successfully redirected to GitHub (which is usually easiest to test in a private browsing session, to visibly see the redirect) but then see errors once you've been redirected back, the first culprit to check is whether you have been redirected back to the right address, so check the URL bar; does it match that for your App Service?

It's common to forget, you'll need to set up a new OAuth app for the Azure application; simply reusing existing Client ID/Client Secret values will lead to the redirect sending you to somewhere that isn't Azure.

If it is, then it sounds like a genuine error; checking that you've set the right environment variables is usually a good starting point, otherwise look at the hints for debugging a broken deployed application.

If your App Service still isn't working take a look at the [hints for Module 9](/Modules/Module_09_Cloud/Project_Exercise/hints.md) too.
</details>
