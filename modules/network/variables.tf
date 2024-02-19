
variable "environment" {
  type = object({
    name = string
    type = string # non-prod, prod
    region = string
      
  })
}

variable "region_name_mapper" {
  type = map(string)
}

variable "network" {
  type = object({
    address_space = string
    subnet_address_prefixes = object({
      appgw = string
      aks  = string
    })
    nat_gateway = bool
  })
}

variable "tags" {
  type = map(string)
}
