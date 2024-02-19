# ---------------------------------------------------------------
# Purpose: Create the aks resources for the environment
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Local variables to hold resource names
# ---------------------------------------------------------------
locals {
  resource_group_name   = "rg-${var.environment.name}-aks-${var.region_name_mapper[var.environment.region]}"
  aks_name              = "aks-${var.environment.name}-${var.region_name_mapper[var.environment.region]}"
  system_node_pool_name = "systemnp"
  subnet_id             = var.network_out.subnets.aks.id

}

# ---------------------------------------------------------------
# Datasource to get Latest Azure AKS latest Version
# ---------------------------------------------------------------


# data "azurerm_kubernetes_service_versions" "current" {
#   location = var.location
#   include_preview = false  
# }


# ---------------------------------------------------------------
# Resource group for the aks
# ---------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.environment.region
  tags     = var.tags
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  location            = var.environment.region
  resource_group_name = local.resource_group_name
  dns_prefix          = "aks-${var.environment.name}"

  default_node_pool {
    name                = "default"
    node_count          = var.aks.node_count
    vm_size             = var.aks.vm_size
    vnet_subnet_id      = local.subnet_id
    enable_auto_scaling = true
    min_count           = var.aks.min_node_count
    max_count           = var.aks.max_node_count

  }


  network_profile {
    network_plugin = "azure"
    network_policy = "calico" // or "azure" for Azure network policies
  }

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "system" {
  name                  = local.system_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.aks.vm_size_system
  node_count            = var.aks.node_count_system
  mode                  = "System"
  enable_auto_scaling   = true
  min_count             = var.aks.min_node_count_system
  max_count             = var.aks.max_node_count_system

}
