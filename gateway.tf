# Public IP for Application Gateway
resource "azurerm_public_ip" "appgw_pip" {
  count               = var.create_appgw_public_ip ? 1 : 0
  name                = "${local.appgw_name}-pip"
  resource_group_name = module.rg_network.name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = local.appgw_name
  resource_group_name = module.rg_network.name
  location            = local.location

  # SKU Configuration
  sku {
    name     = var.appgw_sku_name
    tier     = var.appgw_sku_tier
    capacity = var.appgw_capacity
  }

  # Gateway IP Configuration
  gateway_ip_configuration {
    name      = "${local.appgw_name}-gateway-ip-config"
    subnet_id = azurerm_subnet.subnet_appgw.id
  }

  frontend_ip_configuration {
    name                 = "public"
    public_ip_address_id = var.create_appgw_public_ip ? azurerm_public_ip.appgw_pip[0].id : null
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  backend_address_pool {
    name = "${local.appgw_name}-backend-pool"
  }

  backend_http_settings {
    name                  = "${local.appgw_name}-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "${local.appgw_name}-http-listener"
    frontend_ip_configuration_name = "public"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.appgw_name}-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "${local.appgw_name}-http-listener"
    backend_address_pool_name  = "${local.appgw_name}-backend-pool"
    backend_http_settings_name = "${local.appgw_name}-backend-http-settings"
    priority                   = 100
  }
}

