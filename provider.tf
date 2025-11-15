terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

  # Backend configuration - values will be provided via --backend-config
  backend "azurerm" {
    # Values are provided via --backend-config file
    # Example: terraform init --backend-config=Environments/Dev/dev.tfbackend
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "333359c5-cc92-4749-8db5-60b6741fdb15"

}