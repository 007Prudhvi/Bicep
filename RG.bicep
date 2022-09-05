targetScope = 'subscription'

param resourcegroupname string = 'BICEP-DEV'
param resourcegrouplocation string = 'eastus'

resource RG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourcegroupname
  location: resourcegrouplocation
}
