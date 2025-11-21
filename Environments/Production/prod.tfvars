# Azure Infrastructure - Production Environment

# Location
location = "eastus"

# Network Configuration
vnet_address_space = ["10.1.0.0/16"]
subnet_app_cidr    = "10.1.1.0/24"
subnet_db_cidr     = "10.1.2.0/24"
subnet_appgw_cidr  = "10.1.3.0/24"

# Storage Account Configuration
storage_account_name             = "stprodnetworkeastus001"
storage_account_tier             = "Standard"
storage_account_replication_type = "GRS"
storage_account_kind             = "StorageV2"

# Virtual Machine Configuration
vm_name              = "vm-prod-main"
vm_size              = "Standard_B2s"
vm_zone              = 1
create_public_ip     = true
public_ip_allocation = "Static"

# VM Admin Credentials
admin_username       = "azureuser"
admin_ssh_public_key = ""

# VM Disk Configuration
os_disk_size_gb = 64
os_disk_type    = "Premium_LRS"

# Application Gateway Configuration
appgw_name             = "appgw-prod-main"
appgw_sku_name         = "WAF_v2"
appgw_sku_tier         = "WAF_v2"
appgw_capacity         = 2
create_appgw_public_ip = true
