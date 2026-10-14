# $labid = ""
# =======
$labid = ""

$tenantId = (az account show --query tenantId -o tsv)

$subscriptionId = (az account show --query id -o tsv)

$resourceGroup = "azureaiworkshoprg"

$foundryName = "ai-foundry-${labid}"

# Get the values 
# Get the foundry key
$foundryKey = (az cognitiveservices account keys list --name $foundryName --resource-group $resourceGroup --query key1 -o tsv)

$aisearch="aisearch-${labid}"
# Get the search key
$searchKey = (az search admin-key show --service-name $aisearch --resource-group $resourceGroup --query primaryKey -o tsv)

$cosmosdb="cosmosaivector-${labid}"
# Get the cosmos key
$cosmosKey = (az cosmosdb keys list --name $cosmosdb --resource-group $resourceGroup --type keys --query primaryMasterKey -o tsv)

$sql="sqlaivector-${labid}"

# $sqlPassword = Read-Host "Enter SQL password"

Write-Host "foundry_key=`"${foundryKey}`""
Write-Host "tenantId=`"${tenantId}`""
Write-Host "subscriptionId=`"${subscriptionId}`""
Write-Host "searchKey=`"${searchKey}`""
Write-Host "cosmosKey=`"${cosmosKey}`""
Write-Host "sqlPassword=`"Your SQL password {this is in the root of Labs folder}`""