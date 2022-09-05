@description('Specifies the location for resources.')
param storageaccountname string

//* New-AzResourceGroupDeployment -ResourceGroupName MyLearnRG-Bicep -TemplateFile .\StorageAccount.bicep *//
resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageaccountname
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}
