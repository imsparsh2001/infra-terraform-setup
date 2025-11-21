module "rg_network" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = local.resource_group_name
  location = local.location
}


# Virtual Network 

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.16.0"

  parent_id     = module.rg_network.resource_id
  location      = local.location
  name          = local.vnet_name
  address_space = var.vnet_address_space
}

# Subnets
resource "azurerm_subnet" "subnet_app" {
  name                 = local.subnet_app_name
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet.name
  address_prefixes     = [var.subnet_app_cidr]
}

resource "azurerm_subnet" "subnet_db" {
  name                 = local.subnet_db_name
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet.name
  address_prefixes     = [var.subnet_db_cidr]
}

resource "azurerm_subnet" "subnet_appgw" {
  name                 = local.subnet_appgw_name
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet.name
  address_prefixes     = [var.subnet_appgw_cidr]
}

