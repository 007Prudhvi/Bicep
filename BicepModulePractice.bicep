// Resource: Key Vault
module kv './keyvault.bicep' = {
  name: 'keyVaultModule'
    }

// Resource: Storage Account
module storage './storageaccount.bicep' = {
  name: 'storageModule'
 }

// output objects.
output deploymentResourceGroup object = resourceGroup()
