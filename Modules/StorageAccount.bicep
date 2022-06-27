//* New-AzResourceGroupDeployment -ResourceGroupName MyLearnRG-Bicep -TemplateFile .\StorageAccount.bicep *//
resource sa 'Microsoft.Storage/storageAccounts@2021-06-01'= {
  name: 'phanibicepsa'
  location: 'EastUS'
  kind: 'StorageV2'
  sku: {
    name : 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}
