var vaultName_var = 'rsv-vault01'

resource vaultName 'Microsoft.RecoveryServices/vaults@2016-06-01' = {
  location: resourceGroup().location
  name: vaultName_var
  sku: {
    name: 'RS0'
  }
  properties: {}
}

resource vaultName_vaultstorageconfig 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2018-12-20' = {
  name: '${vaultName.name}/vaultstorageconfig'
  properties: {
    storageModelType: 'GeoRedundant'
  }
}

resource vaultName_standard_backup 'Microsoft.RecoveryServices/vaults/backupPolicies@2019-06-15' = {
  name: '${vaultName.name}/standard-backup'
  location: resourceGroup().location
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 2
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '21:00'
      ]
      schedulePolicyType: 'SimpleSchedulePolicy'
    }
    retentionPolicy: {
      dailySchedule: {
        retentionTimes: [
          '21:00'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
      weeklySchedule: {
        daysOfTheWeek: [
          'Sunday'
        ]
        retentionTimes: [
          '21:00'
        ]
        retentionDuration: {
          count: 4
          durationType: 'Weeks'
        }
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    timeZone: 'W. Europe Standard Time'
  }
}
