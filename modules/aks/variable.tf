variable "environment" {
  type = object({
    name   = string
    type   = string # non-prod, prod
    region = string

  })
}

variable "network_out" {
  type = object({
    subnets = map(object({
      id   = string
      name = string
    }))
    vnet = object({
      id       = string
      location = string
      name     = string
    })
  })
  description = "Configuration for each network"
}

variable "aks" {
  type = object({
    node_count            = number
    vm_size               = string
    node_count_system     = number
    vm_size_system        = string
    min_node_count        = number
    max_node_count        = number
    min_node_count_system = number
    max_node_count_system = number
  })
}



variable "tags" {
  type = map(string)
}

variable "region_name_mapper" {
  type = map(string)
}
