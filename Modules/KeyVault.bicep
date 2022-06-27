resource KV 'Microsoft.KeyVault/vaults@2019-09-01' = {
  location: 'EastUS'
  name: 'myKVDemoBicep'
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
      }
      accessPolicies: [
      ]
  }
}

output keyvaulturi string = KV.properties.vaultUri
output keyvaultskuName string = KV.properties.sku.name
