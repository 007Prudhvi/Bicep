param location string
param AppServiceAppName string

@allowed([
'nonprod'
'prod'
  ])
param EnvironmentType string

var AppServicePlanName = 'toy-product-launch-plan'
var AppServicePlanSKUName = (EnvironmentType == 'prod') ? 'P2_v3' : 'F1'

resource AppServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: AppServicePlanName
  location: location
  sku: {
    name: AppServicePlanSKUName
  }
}

resource AppServiceApp 'Microsoft.Web/sites@2021-02-01' = {
  name: AppServiceAppName
  location: location
properties: {
  serverFarmId: AppServicePlan.id
  httpsOnly: true
  }
}

output appServiceAppHostName string = AppServiceApp.properties.defaultHostName
