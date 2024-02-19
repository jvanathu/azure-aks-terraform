variable "environment" {
  type = object({
    name   = string
    type   = string # dev, uat, prod
    region = string
  })
  validation {
    condition     = contains(["non-prod", "prod"], var.environment.type)
    error_message = "Valid values for var: environment.type are (non-prod, prod)."
  }
}

variable "region_name_mapper" {
  type = map(string)
  default = {
    "eastus" = "eus"
  }
}

variable "connect_client_id" {
  type = string
}

variable "connect_client_secret" {
  type = string
}

variable "connect_tenant_id" {
  type = string
}

variable "connect_subscription_id" {
  type = string
}

variable "network" {
  type = object({
      address_space = string
      subnet_address_prefixes = object({
        appgw = string
        aks   = string
      })
      nat_gateway = bool
    })
}

variable "aks" {
  type = object({
    node_count              = number
    vm_size                 = string
    node_count_system       = number
    vm_size_system          = string
    min_node_count          = number
    max_node_count          = number
    min_node_count_system   = number
    max_node_count_system   = number
  })
}


variable "tags" {
  type = map(string)
}