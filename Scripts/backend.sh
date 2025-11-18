#!/bin/bash

RESOURCE_GROUP_NAME=Sparsh_Jaipuriyar
STORAGE_ACCOUNT_NAME=terraformbackend$RANDOM
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME


# steps to run the cli command to create the storage container
# 1.write the cli command in backend.sh file 
# 2. go to the current working directory and run the command 
# --> chmod 775 backend.sh
# -->./backend.sh
