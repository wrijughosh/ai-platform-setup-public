#Get the Lab Id once the lab is created, this will be used to create the Foundry Lab
write-host "Please make sure the Lab Id is correct"
${labid} = ""

$confirmation = Read-Host "Lab ID is ${labid}. Press Y to continue, or any other key to terminate"
if ($confirmation -notmatch '^[Yy]$') {
	write-host "Terminating script."
	exit
}

# =================================================

write-host "Creating Foundry Lab with ID: ${labid}"

$tenantId = (az account show --query tenantId -o tsv)
write-host "Tenant ID: ${tenantId}"

$subscriptionId = (az account show --query id -o tsv)
write-host "Subscription ID: ${subscriptionId}"

# variables 
$foundryName = "ai-foundry-${labid}"
$resourceGroup = "azureaiworkshoprg"
$location="swedencentral"

write-host "Creating Foundry Lab with Name: ${foundryName} in Resource Group: ${resourceGroup} at Location: ${location}"
az cognitiveservices account create `
	--name $foundryName `
	--resource-group $resourceGroup `
	--location $location `
	--kind AIServices `
	--sku S0 `
	--custom-domain $foundryName

$projectName = "firstProject"
write-host "Creating Project with Name: ${projectName} in Foundry: ${foundryName}"
az cognitiveservices account project create `
	--project-name $projectName `
	--name $foundryName `
	--resource-group $resourceGroup `
	--location $location

# $groundingBing="gwbing"+$labid



$modelDeployments = @(
	@{ DeploymentName = "text-embedding-3-large"; ModelName = "text-embedding-3-large"; ModelVersion = "1"; SkuName = "Standard" },
	@{ DeploymentName = "gpt-5.1"; ModelName = "gpt-5.1"; ModelVersion = "2025-11-13"; SkuName = "GlobalStandard" },
	@{ DeploymentName = "gpt-5-mini"; ModelName = "gpt-5-mini"; ModelVersion = "2025-08-07"; SkuName = "GlobalStandard" },
	@{ DeploymentName = "text-embedding-ada-002"; ModelName = "text-embedding-ada-002"; ModelVersion = "2"; SkuName = "Standard" }
)

foreach ($deployment in $modelDeployments) {
	write-host "Deploying model $($deployment.ModelName) as $($deployment.DeploymentName)"
	az cognitiveservices account deployment create `
		--name $foundryName `
		--resource-group $resourceGroup `
		--deployment-name $deployment.DeploymentName `
		--model-format OpenAI `
		--model-name $deployment.ModelName `
		--model-version $deployment.ModelVersion `
		--sku-name $deployment.SkuName `
		--sku-capacity 1
}

write-host "--------------------------------" 
write-host "Created Foundry with Name: ${foundryName}, Project: ${projectName} in Resource Group: ${resourceGroup} at Location: ${location}"
write-host "*** Pending ***"
write-host "Manually create connected resources Bing and AI Search in the Foundry portal for the lab to complete the setup."


# =======================================
# Read the keys for the created resources
# =======================================

# Get the foundry key
$foundryKey = (az cognitiveservices account keys list --name ${foundryName} --resource-group ${resourceGroup} --query key1 -o tsv)

$aisearch="aisearch-${labid}"
# Get the search key
$searchKey = (az search admin-key show --service-name ${aisearch} --resource-group ${resourceGroup} --query primaryKey -o tsv)

$cosmosdb="cosmosaivector-${labid}"
# Get the cosmos key
$cosmosKey = (az cosmosdb keys list --name ${cosmosdb} --resource-group ${resourceGroup} --type keys --query primaryMasterKey -o tsv)

$sql="sqlaivector-${labid}"

# $sqlPassword = Read-Host "Enter SQL password"

Write-Host "foundry_key=`"${foundryKey}`""
Write-Host "tenantId=`"${tenantId}`""
Write-Host "subscriptionId=`"${subscriptionId}`""
Write-Host "searchKey=`"${searchKey}`""
Write-Host "cosmosKey=`"${cosmosKey}`""
Write-Host "sqlPassword=`"Your SQL password`""

#=======================================================