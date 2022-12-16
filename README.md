# LibreTranslate on Azure using Bicep
Easy and simple way to deploy LibreTranslate into Azure App Service

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmhdbouk%2Flibretranslate-bicep%2Fmain%2Fmain.json)

## main.bicep
When deploying `main.bicep` to azure, it will create a new Linux-based Azure App Service Plan and configure a new Azure Web App with the necessary settings and configuration to run [LibreTranslate](https://github.com/LibreTranslate/LibreTranslate) from Docker

There is also an option to use your own Azyre Container Registry (ACR), by changing the `Container Registry` parameter to the URL of your custom registry.

Please note that in this example, `LibreTranslate` will only be configured to start with support for English, Arabic, and Chinese languages.

To deploy main.bicep on Azure using the Azure CLI and Bicep CLI, follow these steps:
1. Install the Azure CLI and Bicep CLI on your local machine.
2. Open a terminal and log in to your Azure account using the Azure CLI:
```
az login
```
3. Set the subscription that you want to use for the deployment:
```
az account set --subscription YOUR_SUBSCRIPTION_ID
```
4. Use the Bicep CLI to build and deploy the `main.bicep` file:
```
bicep build main.bicep
az deployment group create --resource-group YOUR_RESOURCE_GROUP_NAME --template-file main.json
```

You should now have a succesfful deployment of `main.bicep` on Azure.

## libretranslatepush.ps1
This PowerShell script can be used to pull the latest version of LibreTranslate from Docker Hub and push it to your Azure Container Registry (ACR). Simply provide the script with the name of your ACR and the URL.

For example:
```
.\libretranslatepush.ps1 -registryName myacr -registryUrl myacr.azurecr.io
```

This script is useful if you want to keep your ACR up to date with the latest version of LibreTranslate. You can set it up as part of your continuous integration or deployment workflow to ensure that your libretranslate web app is always running the latest version.
