targetScope = 'subscription'

param rgname string = 'TMM-MGTUS-RG'
param rglocation string = 'eastus'

resource RG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgname
  location: rglocation
  tags: { SBU: 'FMM', Environment: 'PROD' }
  properties: {}
}

module SA './Modules/StorageAccount.bicep' = {
  name: 'DiagnosticsStorage'
  scope: RG
}
