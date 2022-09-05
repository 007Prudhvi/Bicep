targetScope = 'subscription'

param resourcegroupname string = 'FMM-FMS-UiPath-RG'

param resourcegrouplocation string = 'EastUS'

resource RG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: resourcegrouplocation
  name: resourcegroupname
}
