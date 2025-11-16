# Generate SSH key 
resource "tls_private_key" "autogen_ssh" {
  count     = var.admin_ssh_public_key == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Virtual Machine 
module "vm" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.20.0"

  location            = local.location
  resource_group_name = module.rg_network.name
  name                = local.vm_name
  zone                = var.vm_zone
  os_type             = "Linux"

  network_interfaces = {
    primary = {
      name = "${local.vm_name}-nic"
      ip_configurations = {
        internal = {
          name                          = "internal"
          private_ip_subnet_resource_id = azurerm_subnet.subnet_app.id
          private_ip_address_allocation = "Dynamic"
          create_public_ip_address      = var.create_public_ip
          public_ip_address_name        = var.create_public_ip ? "${local.vm_name}-pip" : null
        }
      }
    }
  }

  # VM sizing
  sku_size = var.vm_size

  # OS disk configuration
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  # Image reference (Ubuntu LTS)
  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Account credentials (Linux configuration)
  account_credentials = {
    admin_credentials = {
      username                        = var.admin_username
      ssh_keys                        = var.admin_ssh_public_key != "" ? [var.admin_ssh_public_key] : []
      generate_admin_password_or_ssh_key = var.admin_ssh_public_key == "" ? true : false
    }
    password_authentication_disabled = true
  }

}
