#!/bin/bash

ARM_TENANT_ID=""
ARM_SUBSCRIPTION_ID=""
ARM_CLIENT_ID=""
ARM_CLIENT_SECRET=""

# Login to Azure
az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

# View subscriptions
az account show

# Set subscription
az account set --subscription $ARM_SUBSCRIPTION_ID
