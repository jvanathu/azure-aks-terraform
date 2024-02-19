locals {
  nat_public_ip_name = "pip-${var.environment.name}-nat-${var.region_name_mapper[var.environment.region]}"
  nat_gateway_name   = "nat-${var.environment.name}-${var.region_name_mapper[var.environment.region]}"
  route_table_name   = "rt-${var.environment.name}-${var.region_name_mapper[var.environment.region]}"
}

# Create a Public IP for the NAT Gateway
resource "azurerm_public_ip" "nat_gateway_ip" {
  count               = var.network.nat_gateway ? 1 : 0
  name                = local.nat_public_ip_name
  location            = var.environment.region
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create the NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  count               = var.network.nat_gateway ? 1 : 0
  name                = local.nat_gateway_name
  location            = var.environment.region
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"
}

# Associate the Public IP with the NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_ip_association" {
  count                = var.network.nat_gateway ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.0.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip.0.id
}

locals {
  nat_subnets = {
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


# Associate Subnets with the NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assocuation" {
  # for_each = var.network.nat_gateway ? toset([for s in azurerm_virtual_network.vnet.subnet : s.id if s.name != "AzureBastionSubnet"]) : toset([])
  for_each       = var.network.nat_gateway ? {for k,v in local.nat_subnets: k=> v if v!=null} : {}
  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.0.id
  depends_on     = [azurerm_virtual_network.vnet]
}

# Route Table for the NAT Gateway
# resource "azurerm_route_table" "rt" {
#   count              = var.network.nat_gateway ? 1 : 0
#   name                = local.route_table_name
#   location            = var.network.location
#   resource_group_name = azurerm_resource_group.rg.name

#   # route {
#   #   name                   = "outbound-to-nat-gateway"
#   #   address_prefix         = "0.0.0.0/0"
#   #   next_hop_type          = "Internet"
#   #   next_hop_in_ip_address = azurerm_nat_gateway.nat_gateway.0.id
#   # }
# }

# resource "azurerm_subnet_route_table_association" "rt_subnet_association" {
#   for_each             = var.network.nat_gateway ? toset([for s in azurerm_virtual_network.vnet.subnet : s.id if s.name != "AzureBastionSubnet"]) : toset([])
#   subnet_id            = each.value
#   route_table_id       = azurerm_route_table.rt.0.id
# }
