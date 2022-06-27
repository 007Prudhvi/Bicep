resource StorageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'phanibicepsa'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
    }
kind: 'StorageV2'
properties: {
  accessTier: 'Hot'
}
}
