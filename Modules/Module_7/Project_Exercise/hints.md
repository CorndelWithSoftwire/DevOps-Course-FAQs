# Module 7 Project Exercise Hints

Are you seeing any of the below issues?

<details markdown="1">
<summary markdown="1">
Nothing happens after I push a change
</summary>

You should see a new workflow appear on your repository within seconds of pushing your changes. If your yml file is invalid, it will tell you.

If nothing happens, here are some things to check:
* For GitHub actions, you need a workflow file with a name ending in `.yml` and it must be located at exactly `.github/workflows/`
* For GitLab CI, you need a file called exactly `.gitlab-ci.yml` in the root folder of your project 
* Check that your pipeline is configured to run for push requests and you are not restricting it to a specific branch, e.g. with a `branches` mapping in GitHub Actions or `only` in GitLab CI. 
* GitHub has had incidents in the past where GitHub Actions was running with a significant delay. You should be able to check whether that's currently the case via their status page: https://www.githubstatus.com/    

</details>


<details markdown="1">
<summary markdown="1">
My scheduled trigger isn't working (stretch goal)
</summary>

Scheduled workflows only get triggered on the default branch (`main`), so you'll have to merge first.

Also worth noting they run on UTC time, so your cron expression might not execute when you expected.

Finally, GitHub doesn't always run scheduled jobs exatly on time for non-paid customers if GitHub actions is busy, so don't be surprised if it runs a few minutes late.

</details>
