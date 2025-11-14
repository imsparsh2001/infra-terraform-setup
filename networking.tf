module "rg_vnet" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = local.resource_group.network
  location = local.location
}

// network security groups
module "nsg_resources" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.4.0"

  resource_group_name = module.rg_vnet.name
  location            = local.location
  name                = local.network.resources_subnet_nsg
}

// vnet
module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  resource_group_name = module.rg_vnet.name
  location            = local.location
  name                = local.network.vnet_name
  address_space       = local.network.vnet_address_space

  diagnostic_settings = {
    sendToLogAnalytics = {
      name                           = "sendToLogAnalytics"
      workspace_resource_id          = module.workspace.resource_id
      log_analytics_destination_type = "Dedicated"
    }
  }

  peerings = {
    peertohub = {
      name                               = "carbon-to-hub"
      remote_virtual_network_resource_id = data.azurerm_virtual_network.hub.id
      allow_forwarded_traffic            = true
      allow_gateway_transit              = false
      allow_virtual_network_access       = true
      do_not_verify_remote_gateways      = false
      enable_only_ipv6_peering           = false
      use_remote_gateways                = true

      create_reverse_peering                = true
      reverse_name                          = "hub-to-carbon"
      reverse_allow_forwarded_traffic       = true
      reverse_allow_gateway_transit         = true
      reverse_allow_virtual_network_access  = true
      reverse_do_not_verify_remote_gateways = false
      reverse_enable_only_ipv6_peering      = false
      reverse_use_remote_gateways           = false
    }
    peertovanadium = {
      name                               = "carbon-to-vanadium"
      remote_virtual_network_resource_id = data.azurerm_virtual_network.vanadium.id
      allow_forwarded_traffic            = true
      allow_gateway_transit              = false
      allow_virtual_network_access       = true
      do_not_verify_remote_gateways      = true
      enable_only_ipv6_peering           = false
      use_remote_gateways                = false

      create_reverse_peering                = true
      reverse_name                          = "vanadium-to-carbon"
      reverse_allow_forwarded_traffic       = true
      reverse_allow_gateway_transit         = false
      reverse_allow_virtual_network_access  = true
      reverse_do_not_verify_remote_gateways = true
      reverse_enable_only_ipv6_peering      = false
      reverse_use_remote_gateways           = false
    }
  }
}

// subnets
resource "azurerm_subnet" "resources" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.resources_subnet_name
  address_prefixes                              = local.network.resources_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
}

resource "azurerm_subnet" "aro_main" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.aro_main_subnet_name
  address_prefixes                              = local.network.aro_main_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "aro_worker" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.aro_worker_subnet_name
  address_prefixes                              = local.network.aro_worker_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "aro_infrastructure" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.aro_infrastructure_subnet_name
  address_prefixes                              = local.network.aro_infrastructure_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "aro_ingress" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.aro_ingress_subnet_name
  address_prefixes                              = local.network.aro_ingress_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "privatelink" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.privatelink_subnet_name
  address_prefixes                              = local.network.privatelink_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
}

resource "azurerm_subnet" "appgw_ingress" {
  resource_group_name                           = module.rg_vnet.name
  virtual_network_name                          = module.vnet.name
  name                                          = local.network.ag_ingress_subnet_name
  address_prefixes                              = local.network.ag_ingress_subnet_ips
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
}

// subnet-nsg associations
resource "azurerm_subnet_network_security_group_association" "resources" {
  subnet_id                 = azurerm_subnet.resources.id
  network_security_group_id = module.nsg_resources.resource_id
}