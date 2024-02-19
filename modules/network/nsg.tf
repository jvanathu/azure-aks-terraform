
# ---------------------------------------------------------------
# External App Gateway NSG
# ---------------------------------------------------------------
resource "azurerm_network_security_group" "appgw_nsg" {
  count               = var.network.subnet_address_prefixes.appgw != null ? 1 : 0
  name                = local.appgw_nsg_name
  location            = var.environment.region
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  security_rule {
    name                       = "AllowHealthProbesInbound"
    priority                   = 100
    protocol                   = "*"
    destination_port_range     = "65200-65535"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowTLSInbound"
    priority                   = 110
    protocol                   = "Tcp"
    destination_port_range     = "443"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPInbound"
    priority                   = 111
    protocol                   = "Tcp"
    destination_port_range     = "80"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInbound"
    priority                   = 121
    protocol                   = "*"
    destination_port_range     = "*"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
}

# ---------------------------------------------------------------
# Internal APIM NSG
# ---------------------------------------------------------------
resource "azurerm_network_security_group" "aks_nsg" {
  count               = var.network.subnet_address_prefixes.aks != null ? 1 : 0
  name                = local.aks_nsg_name
  location            = var.environment.region
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}
