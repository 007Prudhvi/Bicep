param location string = resourceGroup().location
param namePrefix string = 'storage'

var storageAccountname = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_RAGRS'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountname
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
properties: {
  accessTier: 'Hot'
  supportsHttpsTrafficOnly: true
}
}

output storageaccountid string = storageaccount.id
