@description('The name of the environment. This must be dev, test, or prod.')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentname string = 'dev'

@description('The unique name of the solution. This is used to ensure that resource names are unique.')
@minLength(5)
@maxLength(30)
param solutionname string = 'phanihr${uniqueString(resourceGroup().id)}'

@description('The number of App Service plan instances.')
@minValue(1)
@maxValue(10)
param appserviceplaninstancecount int = 1

@description('The name and tier of the App Service plan SKU.')
param appserviceplansku object 

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object

var appserviceplanname = '${environmentname}-${solutionname}-plan'
var appserviceappname = '${environmentname}-${solutionname}-app'
var sqlServerName = '${environmentname}-${solutionname}-sql'
var sqlDatabaseName = 'Employees'

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appserviceplanname
  location: location
  sku: {
    name: appserviceplansku.name
    tier: appserviceplansku.tier
    capacity: appserviceplaninstancecount
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appserviceappname
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: sqlDatabaseSku.name
    tier: sqlDatabaseSku.tier
  }
}
