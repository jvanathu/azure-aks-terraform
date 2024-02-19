output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet" {
  value = {
    name     = azurerm_virtual_network.vnet.name
    id       = azurerm_virtual_network.vnet.id
    location = azurerm_virtual_network.vnet.location
  }
}


output "subnets" {
  value = {
    appgw = var.network.subnet_address_prefixes.appgw != null ? {
      name = local.appgw_subnet_name
      id   = "${azurerm_virtual_network.vnet.id}/subnets/${local.appgw_subnet_name}"
    } : null
    aks = var.network.subnet_address_prefixes.aks != null ? {
      name = local.aks_subnet_name
      id   = "${azurerm_virtual_network.vnet.id}/subnets/${local.aks_subnet_name}"
    } : null
  }
}
