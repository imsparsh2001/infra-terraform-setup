terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

  backend "azurerm" {

  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "333359c5-cc92-4749-8db5-60b6741fdb15"

}