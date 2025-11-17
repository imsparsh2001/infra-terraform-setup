variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_app_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_db_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "storage_account_tier" {
  type    = string
  default = "Standard"
}

variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_account_kind" {
  type    = string
  default = "StorageV2"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name"
}

# Virtual Machine Variables
variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "create_public_ip" {
  type        = bool
  default     = true
  description = "Whether to create a public IP for the VM"
}

variable "public_ip_allocation" {
  type        = string
  default     = "Static"
  description = "Allocation method for public IP "
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "username for the virtual machine"
}

variable "admin_ssh_public_key" {
  type        = string
  default     = ""
  description = "SSH public key for Linux VM authentication"
  sensitive   = false
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "Size of the virtual machine"
}

variable "os_disk_size_gb" {
  type        = number
  default     = 30
  description = "Size of the OS disk in GB"
}

variable "os_disk_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Storage account type for OS disk "
}

variable "vm_zone" {
  type        = number
  default     = null
  description = "Availability zone for the VM"
}


