var VaultName_var = 'AzureBackupRSV-PROD'

resource RecoveryServiceVault 'Microsoft.RecoveryServices/vaults@2021-01-01' = {
  name: VaultName_var
  location: resourceGroup().location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}
