#!/bin/bash

SERVICE_PRINCIPAL_NAME=sp-terraform-nonprod
SUBSCRIPTION_ID=f3a502f0-763f-457e-aa62-d966399d0685

# Create service principal
# https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --role Owner --scopes /subscriptions/$SUBSCRIPTION_ID