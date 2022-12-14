# Module 12 Project Exercise Hints

Are you seeing any of the below issues?

<details markdown="1">
<summary markdown="1">
Errors when creating your CosmosDB resources
</summary>

There are a few potential tripping points when setting up your CosmosDB resources. In particular:
* The docs linked handle _separately_ setting up the CosmosDB account & the actual database. We want one of each resource, both managed with Terraform, so we want to add just two `resource` blocks for this part; we don't need any of the `data` blocks
  * Similarly, if we select a specific unique name for our CosmosDB Account & DB then we won't need any random inputs to generate unique names for us!
* We've been using a "logical name" of `main` by default whereas some examples use `example`. Keep an eye out for these and check you're consistent.
  * For example, if you define your resource with `resource "azurerm_cosmosdb_account" "example" {` then you'll need to reference it with `azurerm_cosmosdb_account.example` rather than `azurerm_cosmosdb_account.main`. 
  * And note that since we're only using resources, we won't need a `data.` prefix to refer to the account we're setting up
* You may need to tweak some settings from the examples, for example we ask you to add the `Serverless` capability, but this might clash with existing example settings
  * In particular, you may need to remove any `throughput` settings, and ensure you have only one `geo_location` block

</details>

<details markdown="1">
<summary markdown="1">
How to use variables
</summary>

At this point our secrets can feel pretty unwieldy; our need to keep them out of the codebase means we need to make sure they're set up in the right order and all hooked together appropriately.

First we need to make sure Terraform expects and uses the variables appropriately, for example you might have a `SECRET_KEY` environment variable that we want Terraform to set. First we create a corresponding `secret_key` variable in Terraform (in our `variables.tf` file):
```tf
variable "secret_key" {
  description = "The secret key used to sign session cookies - should be kept secret!"
  sensitive   = true
}
```

We can then use that variable in our App Service's `app_settings` block to set the relevant variable so that Azure knows what to do with it:
```tf
  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL" = "https://index.docker.io"
    "SECRET_KEY"                 = var.secret_key
    ...
  }
```

However, when we actually apply the Terraform config we need Terraform to know the actual value. Locally, the easiest way might be to add that value to a `terraform.tfvars` file - which will be automatically recognised when running Terraform commands. This file should be added to the `.gitignore` file to ensure the secrets aren't accidentally pushed to our repository however.
```terraform.tfvars
secret_key = "my-secret-key"
```

Given that the `terraform.tfvars` file can't be checked in for our pipeline, we want to separately store our secrets in our repository secrets and convert them into appropriately named environment variables. If we prefix our variable name with `TF_VAR_` then Terraform will pick it up automatically. In GitHub Actions, where we need to explicitly convert from secrets to environment variables, that might look like:

```yml
  infra:
    name: Set up infrastructure with Terraform
    runs-on: ubuntu-latest
    needs: build
    env:
        # Set the necessary access values
        ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
        ...
        # Set the Terraform variables
        TF_VAR_secret_key: '${{ secrets.SECRET_KEY }}'
        TF_VAR_other_variable: 'This one isn't a secret'
    steps:
        ...
```
</details>

<details markdown="1">
<summary markdown="1">
Terraform is complaining that my remote state file is locked
</summary>

Much like your normal file system, Azure Storage blobs can be locked so that multiple systems don't try to modify them at the same time. For example, if your pipeline is running two jobs that both try to run Terraform, the first may block the second - this isn't necessarily a problem and we can always just re-run the job later if we want to.

However, if you are still unable to apply Terraform changes after more than 5 minutes waiting, then it could be that a previous access hasn't been released properly. In general you should be cautious, but here you're likely to be safe breaking that lease manually which you can do through the Azure Portal - navigate to your Storage Account -> Container and find your state file. There will be an option to "Break Lease" on that file if it is currently locked.

</details>

<details markdown="1">
<summary markdown="1">
Terraform runs, but my website doesn't work!
</summary>

At this stage we should be able to debug the system as if it had been set up manually, have you looked at:
* The "Deployment Center" logs - has your Docker image been pulled correctly?
* The App's log stream - are there are any helpful error messages?
* Your environment variables (under the Configuration blade) - do they correspond to those set in your manually configured App Service?
* The URL you're hitting - a common mistake can be to re-use the GitHub OAuth credentials you previously set up, so that you're redirected from your new App Service to the old one

</details>