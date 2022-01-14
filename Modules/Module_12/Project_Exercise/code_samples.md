# Module 12 Project Exercise code samples

Whilst it's good practice to type out your own code, sometimes it's useful to copy and paste from the Project Exercise PDFs.
Unfortunately line breaks and formatting do not always copy correctly, so we replicate the larger code samples here for easy copy-pasting.

## Part 1 Step 1 - Link Terraform to your Azure resource group

```terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.92"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name = "<RESOURCE_GROUP_NAME>"
}
```

## Part 1 Step 3 - Add an App Service and Web App

```terraform
resource "azurerm_app_service_plan" "main" {
  name                = "terraformed-asp"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "<APP_NAME>"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|appsvcsample/python-helloworld:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL" = "https://index.docker.io"
  }
}
```

## Part 2 Step 1 - Input Variables

```terraform
variable "prefix" {
  description = "The prefix used for all resources in this environment"
}
variable "location" {
  description = "The Azure location where all resources in this deployment should be created"
  default     = "uksouth"
}
```
