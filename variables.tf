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
