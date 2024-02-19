brew update && brew install azure-cli
alias tf=terraform
openssl pkcs12 -export -out data/certs/certificate.pfx -inkey data/certs/private-key.pem -in data/certs/full-chain.pem

az login --tenant b5bc7c3d-d7f5-48a4-a38f-7864f685d660
az account set --subscription c0946a49-b1c1-469e-b6e7-94088e571ff9

terraform init \
  -backend-config="resource_group_name=automation"     \
  -backend-config="storage_account_name=virtuapimterraform" \
  -backend-config="container_name=terraform"       \
  -backend-config="key=tfstate/vrtuaksint/terraform.tfstate"

  az storage blob lease break -b terraform.tfstate -c terraform --account-name virtuapimterraform --account-key w0LiwRuClpHKEmt+MmtlgE/nSA/EBB5r3IrLRIxh1rfE3pcL3KoKLMkVY4KedAZUYomwXXyFkNSh+AStxUypdQ==

  az aks command invoke --resource-group rg-vrtuaksint-aks-eus --name aks-vrtuaksint-eus --command "kubectl get pods -n kube-system"

  az aks get-credentials --resource-group rg-vrtuaksint-aks-eus --name aks-vrtuaksint-eus --overwrite-existing

  az aks command invoke --resource-group rg-vrtuaksint-aks-eus --name aks-vrtuaksint-eus --command "kubectl get pods -n kube-system"



  brew update && brew install azure-cli
alias tf=terraform
openssl pkcs12 -export -out data/certs/certificate.pfx -inkey data/certs/private-key.pem -in data/certs/full-chain.pem

az login --tenant b5bc7c3d-d7f5-48a4-a38f-7864f685d660
az account set --subscription c0946a49-b1c1-469e-b6e7-94088e571ff9

terraform init \
  -backend-config="resource_group_name=devops"     \
  -backend-config="storage_account_name=testterraformstats" \
  -backend-config="container_name=testterraformstats"       \
  -backend-config="key=tfstate/terraformstate/terraform.tfstate"



  terraform init \
  -backend-config="resource_group_name=devops" \
  -backend-config="storage_account_name=testterraformstats" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=tfstate/terraformstate/terraform.tfstate"

  az account set --subscription d8b62d3e-e0ea-461d-8965-87724b50e5a6


  az storage blob lease break -b terraform.tfstate -c terraform --account-name virtuapimterraform --account-key w0LiwRuClpHKEmt+MmtlgE/nSA/EBB5r3IrLRIxh1rfE3pcL3KoKLMkVY4KedAZUYomwXXyFkNSh+AStxUypdQ==

az group create --name devops --location EastUS
az storage account create --name testterraformstats --resource-group devops --location EastUS --sku Standard_LRS --encryption-services blob

az storage container create --name tfstate --account-name testterraformstats
az storage account keys list --account-name testterraformstats --resource-group devops


az storage container create --name tfstate --account-name testterraformstats --account-key 6Nf0+rnoEDpEN+nugtdL/d2eBdsUvY/rJ5HcvqN0E0hbFngFlI4jBFDpolp6KeU+l2TvAxB41AxH+AStJYshYw==

az storage container list --account-name testterraformstats --account-key 6Nf0+rnoEDpEN+nugtdL/d2eBdsUvY/rJ5HcvqN0E0hbFngFlI4jBFDpolp6KeU+l2TvAxB41AxH+AStJYshYw==

az storage container create --name CORRECT_CONTAINER_NAME --account-name testterraformstats --account-key 6Nf0+rnoEDpEN+nugtdL/d2eBdsUvY/rJ5HcvqN0E0hbFngFlI4jBFDpolp6KeU+l2TvAxB41AxH+AStJYshYw==
