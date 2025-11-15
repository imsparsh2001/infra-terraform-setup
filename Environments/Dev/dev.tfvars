# Azure Infrastructure - Development Environment

# Location
location = "eastus"

# Network Configuration
vnet_address_space = ["10.0.0.0/16"]
subnet_app_cidr    = "10.0.1.0/24"
subnet_db_cidr     = "10.0.2.0/24"

# Storage Account Configuration
storage_account_name             = "stdevnetworkeastus001"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
storage_account_kind             = "StorageV2"

# Virtual Machine Configuration
vm_name              = "vm-dev-main"
vm_size              = "Standard_B1s"
vm_zone              = null
create_public_ip     = true
public_ip_allocation = "Static"

# VM Admin Credentials
admin_username       = "azureuser"
admin_ssh_public_key = ""

# VM Disk Configuration
os_disk_size_gb = 30
os_disk_type    = "Standard_LRS"


