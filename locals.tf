locals {
  location = var.location

  resource_group_name = "rg-network"
  vnet_name           = "vnet-main"

  subnet_app_name   = "subnet-app"
  subnet_db_name    = "subnet-db"
  subnet_appgw_name = "subnet-appgw"

  vm_name    = var.vm_name
  appgw_name = var.appgw_name
}
