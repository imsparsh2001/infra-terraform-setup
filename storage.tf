# Storage Account using Azure Verified Module

module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.4"

  resource_group_name = module.rg_network.name
  location            = local.location
  name                = var.storage_account_name

  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

}

