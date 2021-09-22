# Travis

Travis has its fair share of quirks. Here we provide some of the common tripping points that you might face!

<details markdown="1">
<summary markdown="1">
Travis isn't running my pipelines at all
</summary>

This is _probably_ caused by a mistake in your YAML. Visit your repository in Travis, select the "More Options" button and click the "Requests" option. This will list out the pipelines that Travis considered running, and why it did or didn't take action.
* If you don't see any requests, you might want to check whether Travis is pointing at the same repository you have been pushing to. If you click the Github icon, does it take you to your repository? Can you see your latest changes?
* If it records that a `.travis.yml` file wasn't found - did you push the file successfully? Was it named correctly?
* If it records that it couldn't parse your file, then there's likely a mistake in your YAML. Take another look over the file - common sources of error are missing hyphens (denoting the next entry in an array) or incorrect indenting.
  * You can easily find lots of YAML linters only - try putting your config into one; does it provide any hints where an error might be?
</details>

<details markdown="1">
<summary markdown="1">
Travis isn't recognising my environment variables
</summary>

The first thing you might want to check is whether Travis acknowledges the environment variable exists at all. At the top of your builds, it should list any environment variables its aware of, saying something like:
```
Setting environment variables from repository settings
$ export TRELLO_BOARD_ID=[secure]
Setting environment variables from .travis.yml
$ export DOCKER_HUB_ID=your-name
```

If the variable is listed there:
* Is the variable being passed to where it's expected? E.g. Docker containers will need to be told which environment variables they should know about - just being set on the VM is not enough!
* Have you [escaped it properly](https://docs.travis-ci.com/user/encryption-keys/#note-on-escaping-certain-symbols)?

If the variable is not listed there:
* If you encrypted it & added it to your `.travis.yml`, did you remember to use `--pro` flag with your encryption command?
</details>