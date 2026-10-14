#these 4 inputs are needed
labid="66155467"
#
foundry_key="YOUR_FOUNDRY_KEY"
tenantId="YOUR_TENANT_ID"
subscriptionId="YOUR_SUBSCRIPTION_ID"
searchKey="YOUR_SEARCH_KEY"
cosmosKey="YOUR_COSMOS_KEY"
sqlPassword="YOUR_SQL_PASSWORD"
#
# Here paste the values STARTS
foundry_key="YOUR_FOUNDRY_KEY"
tenantId="YOUR_TENANT_ID"
subscriptionId="YOUR_SUBSCRIPTION_ID"
searchKey="YOUR_SEARCH_KEY"
cosmosKey="YOUR_COSMOS_KEY"
sqlPassword="YOUR_SQL_PASSWORD"
# Here paste the values ENDS

#below are generated names
foundryName="ai-foundry-" + labid
openaiName="myopai-" + labid

gwbing="gwbing" + labid

aisearch="aisearch-" + labid

cosmosdb="cosmosaivector-" + labid

sql="sqlaivector-" + labid

#fixed---
projName="firstProject"

#Models
gpt51="gpt-5.1"
gpt5mini="gpt-5-mini"
textembedding="text-embedding-3-large"
textembeddingada="text-embedding-ada-002"

#API Version
gpt51ver="2025-04-01-preview"
txtembdver="2023-05-15"
#variable ends here 

def create_env_file(foundry_name, foundryKey, output_path="output.txt", project_name=projName):
	"""Write the Azure environment variables to a multiline text file."""
	env_text = f"""
		AI_FOUNDRY_PROJECT_ENDPOINT="https://{foundry_name}.services.ai.azure.com/api/projects/{project_name}"
		AI_FOUNDRY_NAME="{foundry_name}"
		AZURE_PROJECT_NAME="{project_name}"

		AZURE_OPENAI_ENDPOINT="https://{foundry_name}.openai.azure.com/openai/deployments/{gpt51}/chat/completions?api-version={gpt51ver}"
		AZURE_OPENAI_BASE_URL_ENDPOINT="https://{openaiName}.openai.azure.com/"
		AZURE_OPENAI_API_KEY="{foundryKey}"
		MODEL_DEPLOYMENT_NAME="{gpt51}"
		MODEL_API_VERSION="{gpt51ver}"

		AZURE_OPENAI_EMBEDDING_ENDPOINT="https://{foundry_name}.openai.azure.com/openai/deployments/{textembedding}/chat/completions?api-version={txtembdver}"
		AZURE_OPENAI_EMBEDDING_API_KEY="{foundryKey}"
		EMBEDDING_MODEL_DEPLOYMENT_NAME="{textembedding}"
		EMBEDDING_MODEL_API_VERSION="{txtembdver}"

		AZURE_OPENAI_EMBEDDING_ADA_ENDPOINT="https://{foundry_name}.openai.azure.com/openai/deployments/{textembeddingada}/chat/completions?api-version={txtembdver}"
		AZURE_OPENAI_EMBEDDING_ADA_API_KEY="{foundryKey}"
		EMBEDDING_ADA_MODEL_DEPLOYMENT_NAME="{textembeddingada}"
		EMBEDDING_ADA_MODEL_API_VERSION="{txtembdver}"

		#
		GROUNDING_WITH_BING_CONNECTION_NAME="{gwbing}"

		#
		TENANT_ID="{tenantId}"

		#
		AZURE_SUBSCRIPTION_ID="{subscriptionId}"
		AZURE_RESOURCE_GROUP="azureaiworkshoprg"

		#
		AZURE_AI_SEARCH_ENDPOINT="https://{aisearch}.search.windows.net"
		AZURE_AI_SEARCH_API_KEY="{searchKey}"

		#
		COSMOS_ENDPOINT="https://{cosmosdb}.documents.azure.com:443/"
		COSMOS_KEY="{cosmosKey}"

		#
		SQL_SERVER="{sql}.database.windows.net"
		SQL_PWD="{sqlPassword}"
                    """

	with open(output_path, "w", encoding="utf-8") as env_file:
		env_file.write(env_text)


create_env_file(foundryName, foundry_key)
print("............output.txt file created in this folder")
