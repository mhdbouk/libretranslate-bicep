# Deploy LibreTranslate using Bicep into Azure
Easy and simple way to deploy LibreTranslate into Azure App Service

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmhdbouk%2Flibretranslate-bicep%2Fmain%2Fmain.json)

## main.bicep
This bicep file will generate a new linux based azure app service plan, and generate a new azure web app linked to the plan and configured with all the neede settings and configuration to run [LibreTranslate](https://github.com/LibreTranslate/LibreTranslate) from Docker

There is also an option to use your own ACR, by changing the `Container Registry` Parameter to have the custom registry URL

Please note that in this example LibreTranslate will only start with 3 language: English, Arabic, and Chinese.

## libretranslatepush.ps1
This script can be use to pull LibreTransalte from Docker hub and push it to Azure Container Registry, just provide the script with the name of the ACR and the URL
