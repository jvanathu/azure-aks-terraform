
 My code structure is organized as follows: the root directory contains 'main.tf', 'terraform.tfvars', 'provider.tf', and 'variables.tf'. Additionally, I have created module dir, a 'network' module. This is achieved by creating a 'network' folder  then again main.tf,variable.tf,output.tf


The structure is detailed below:


.
├── modules/                  # Reusable Terraform modules are stored here. Modules are used to     
│   └── network/              # Network module
│       ├── main.tf           # Main resource definitions for the network module, such as Azure 
│       ├── variables.tf      # Variable definitions for the network module
│       └── outputs.tf        # Outputs from the network module
├── provider.tf               # Azure provider configuration
├── terraform.tfvars          # Terraform variables definition file
├── main.tf                   # Main Terraform configuration file
└── variables.tf              # Variable definitions for the root module


