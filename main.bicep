@description('Describes plan\'s pricing tier and instance size. Check details at https://azure.microsoft.com/en-us/pricing/details/app-service/')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param skuName string = 'B1'

@description('Describes plan\'s instance count')
@minValue(1)
@maxValue(3)
param skuCapacity int = 1

@description('Location for all resources.')
param location string = resourceGroup().location

@description('App Service Plan Name.')
param appPlanName string = 'plan-${uniqueString(resourceGroup().id)}'

@description('App Service Name.')
param appName string = 'app-libretranslate-${uniqueString(resourceGroup().id)}'

@description('Container Registry, default Docker Hub')
param containerRegistry string = 'https://index.docker.io'

@description('Container Registry Username, default empty string for Docker Hub')
param containerRegistryUsername string = ''

@description('Container Registry Password, default empty string for Docker Hub')
@secure()
param containerRegistryPassword string = ''

@description('Languages to be loaded from LibreTranslate, separated by ,')
param languages string = 'en,ar,zh'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appPlanName
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}
var registry = containerRegistry == 'https://index.docker.io' ? '' : '${replace(containerRegistry, 'https://', '')}'
var containerUsername = containerRegistry == 'https://index.docker.io' ? '/libretranslate/' : '/'

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: appName
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${registry}${containerUsername}libretranslate:latest'
      appSettings: [
        {
          name: 'WEBSITES_PORT'
          value: '5000'
        }
        {
          name: 'LT_LOAD_ONLY'
          value: languages
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: containerRegistryPassword
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: containerRegistry
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'LT_DISABLE_WEB_UI'
          value: 'false'
        }
      ]
    }
  }
}
