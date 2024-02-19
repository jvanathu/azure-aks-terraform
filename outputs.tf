output "network_out" {
    value       = { 
        vnet = module.network.vnet
        subnets = module.network.subnets
        }
}

