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

variable "subnet_appgw_cidr" {
  type        = string
  description = "CIDR block for Application Gateway subnet"
  default     = "10.0.3.0/24"
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
  description = "Whether to create a public IP for the VM"
}

variable "public_ip_allocation" {
  type        = string
  description = "Allocation method for public IP "
}

variable "admin_username" {
  type        = string
  description = "username for the virtual machine"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for Linux VM authentication"
  sensitive   = false
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "os_disk_size_gb" {
  type        = number
  description = "Size of the OS disk in GB"
}

variable "os_disk_type" {
  type        = string
  description = "Storage account type for OS disk "
}

variable "vm_zone" {
  type        = number
  description = "Availability zone for the VM"
}

# Application Gateway Variables
variable "appgw_name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "appgw_sku_name" {
  type        = string
  description = "SKU name for Application Gateway (Standard_v2 or WAF_v2)"
  default     = "Standard_v2"
}

variable "appgw_sku_tier" {
  type        = string
  description = "SKU tier for Application Gateway (Standard_v2 or WAF_v2)"
  default     = "Standard_v2"
}

variable "appgw_capacity" {
  type        = number
  description = "Capacity (instance count) for Application Gateway"
  default     = 2
}

variable "create_appgw_public_ip" {
  type        = bool
  description = "Whether to create a public IP for Application Gateway"
  default     = true
}

