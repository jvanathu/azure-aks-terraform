#!/bin/bash

RESOURCE_GROUP_NAME=rg-automation-apim-np-eastus
STORAGE_ACCOUNT_NAME=stcputfapimnpeastus
CONTAINER_NAME=terraform
REGION=eastus

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $REGION --tags "Division=Issuer" "Primary_Application=APIM" "Regulation=None" "DMZ=No" "Support_Owner_Email=id@domain.com" "Region=eastus" "Client_Facing=No" "GBU=CIS" "Env=NonProd" "Cost_Center=0000" "Operational_Hours=24x7" "Type=Platform"

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Enable versioning
az storage account blob-service-properties update --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --enable-versioning true

# Create blob container
CONNECTION_STRING=$(az storage account show-connection-string --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --output tsv)
az storage container create --connection-string $CONNECTION_STRING --resource-group $RESOURCE_GROUP_NAME --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Get storage account key
STORAGE_ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' --output tsv)
echo "Storage Account Key: $STORAGE_ACCOUNT_KEY"