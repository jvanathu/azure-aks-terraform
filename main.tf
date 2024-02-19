
module "network" {
  source             = "./modules/network"
  environment        = var.environment
  region_name_mapper = var.region_name_mapper
  network = var.network
  tags = var.tags
}



module "aks" {
  source             = "./modules/aks"
  environment        = var.environment
  region_name_mapper = var.region_name_mapper
  network_out     = module.network
  aks = var.aks
  tags = var.tags
}
