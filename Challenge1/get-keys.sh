#!/bin/bash
#
# This script will retrieve necessary keys and properties from Azure Resources 
# deployed using "Deploy to Azure" button and will store them in a file named
# "config.env" in the current directory.

# Login to Azure
if [ -z "$(az account show)" ]; then
  echo "User not signed in Azure. Signin to Azure using 'az login' command."
  az login --use-device-code
fi

# Get the resource group name from the script parameter named resource-group
user=""

# Parse named parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --user-number) user="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if resourceGroupName is provided
if [ -z "$user" ]; then
    echo "Enter the user number you are using:"
    read user
fi


# Extract the resource names from the output parameters
echo "Extracting the resource names from the output parameters..."
cosmosdbAccountName="cosmos-rg-aitour-user$user"
storageAccountName="storageaitouruser$user"
documentIntelligenceName="docint-rg-aitour-user$user"
aiCognitiveServicesName="openai-aitour-shared"
#searchServiceName=$(jq -r '.searchServiceName.value' tmp_outputs.json)

resourceGroupName="rg-aitour-user$user"

# Get the keys from the resources
echo "Getting the keys from the resources..."
cosmosdbAccountKey=$(az cosmosdb keys list --name $cosmosdbAccountName --resource-group $resourceGroupName --query primaryMasterKey -o tsv)
cosmosdbEndpoint=$(az cosmosdb show --name $cosmosdbAccountName --resource-group $resourceGroupName --query "documentEndpoint" -o tsv)
storageAccountKey=$(az storage account keys list --account-name $storageAccountName --resource-group $resourceGroupName --query "[0].value" -o tsv)
storageAccountConnectionString=$(az storage account show-connection-string --name $storageAccountName --resource-group $resourceGroupName --query connectionString -o tsv)
documentIntelligenceEndpoint=$(az cognitiveservices account show --name $documentIntelligenceName --resource-group $resourceGroupName --query "properties.endpoints.FormRecognizer" -o tsv)
documentIntelligenceKey=$(az cognitiveservices account keys list --name $documentIntelligenceName --resource-group $resourceGroupName --query key1 -o tsv)
aiCognitiveServicesEndpoint=$(az cognitiveservices account show --name openai-aitour-shared --resource-group rg-aitour-shared --query properties.endpoint -o tsv)
aiCognitiveServicesKey=$(az cognitiveservices account keys list --name openai-aitour-shared --resource-group rg-aitour-shared --query key1 -o tsv)
#searchServiceKey=$(az search admin-key show --resource-group $resourceGroupName --service-name $searchServiceName --query primaryKey -o tsv)

# Overwrite the existing config.env file
if [ -f ../.env ]; then
	rm ../.env
fi

# Store the keys and properties in a file
echo "Storing the keys and properties in '.env' file..."
echo "STORAGE_ACCOUNT_NAME=\"$storageAccountName\"" >> ../.env
echo "STORAGE_KEY=\"$storageAccountKey\"" >> ../.env
echo "STORAGE_CONNECTION_STRING=\"$storageAccountConnectionString\"" >> ../.env
echo "COSMOS_ENDPOINT=\"$cosmosdbEndpoint\"" >> ../.env
echo "COSMOS_KEY=\"$cosmosdbAccountKey\"" >> ../.env
echo "DOC_AI_ENDPOINT=\"$documentIntelligenceEndpoint\"" >> ../.env
echo "DOC_AI_KEY=\"$documentIntelligenceKey\"" >> ../.env
echo "AZURE_OPENAI_ENDPOINT=\"$aiCognitiveServicesEndpoint\"" >> ../.env
echo "AZURE_OPENAI_KEY=\"$aiCognitiveServicesKey\"" >> ../.env
#echo "SEARCH_SERVICE_NAME=\"$searchServiceName\"" >> ../.env
#echo "SEARCH_ADMIN_KEY=\"$searchServiceKey\"" >> ../.env

echo "Keys and properties are stored in '.env' file successfully."