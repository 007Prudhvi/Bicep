//* New-AzSubscriptionDeployment -Location WestEurope -TemplateFile .\ResourceGroup.Bicep *//
targetScope = 'subscription'

param resourcegroupname string = 'BicepRG'
param resourcegrouplocation string = 'EastUS'

resource newRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name:resourcegroupname
  location:resourcegrouplocation
}
