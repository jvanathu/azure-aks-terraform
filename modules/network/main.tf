# ---------------------------------------------------------------
# Purpose: Create the network resources for the environment
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Local variables to hold resource names
# ---------------------------------------------------------------
locals {
  resource_group_name = "rg-${var.environment.name}-network-${var.region_name_mapper[var.environment.region]}"
  vnet_name           = "vnet-${var.environment.name}-${var.region_name_mapper[var.environment.region]}"

  appgw_subnet_name = "sn-appgw"
  aks_subnet_name  = "sn-aks"

  appgw_nsg_name = "nsg-appgw"
  aks_nsg_name  = "nsg-aks"
}

# ---------------------------------------------------------------
# Resource group for the network
# ---------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.environment.region
  tags     = var.tags
}

# ---------------------------------------------------------------
# Virtual network for the resources
# ---------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.environment.region
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.network.address_space]
  //enableVmProtection: false
  //ddos_protection_plan false

  # Subnet for the external application gateway
  dynamic "subnet" {
    for_each = var.network.subnet_address_prefixes.appgw != null ? [var.network.subnet_address_prefixes.appgw] : []
    content {
      name           = local.appgw_subnet_name
      address_prefix = var.network.subnet_address_prefixes.appgw
      security_group = azurerm_network_security_group.appgw_nsg[0].id
    }
  }

  # Subnet for the external API management
  dynamic "subnet" {
    for_each = var.network.subnet_address_prefixes.aks != null ? [var.network.subnet_address_prefixes.aks] : []
    content {
      name           = local.aks_subnet_name
      address_prefix = var.network.subnet_address_prefixes.aks
      security_group = azurerm_network_security_group.aks_nsg[0].id
    }
  }

  tags = var.tags
}
