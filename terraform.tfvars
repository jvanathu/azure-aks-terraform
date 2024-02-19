environment = {
  name   = "vrtuaksint"
  type   = "non-prod"
  region = "eastus"

}

connect_tenant_id       = ""
connect_subscription_id = ""
connect_client_id       = ""
connect_client_secret   = ""

network = {
    address_space = "10.106.108.0/22"
    subnet_address_prefixes = {
      aks   = "10.106.108.0/24"
      appgw = "10.106.109.0/25"
    }
    nat_gateway = false
}

aks = {

    node_count            = 1
    min_node_count        = 1
    max_node_count        = 3
    vm_size               = "Standard_DS2_v2"
    node_count_system     = 1
    min_node_count_system = 1
    max_node_count_system = 3
    vm_size_system        = "Standard_DS2_v2"
  
}

tags = {
  Division            = "Issuer"
  Primary_Application = "APIM"
  Regulation          = "None"
  DMZ                 = "No"
  Support_Owner_Email = "id@domain.com"
  Region              = "eastus"
  Client_Facing       = "No"
  GBU                 = "CIS"
  Env                 = "NonProd"
  Cost_Center         = "0000"
  Operational_Hours   = "24x7"
  Type                = "Platform"
}