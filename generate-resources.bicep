
@description('Generated from /subscriptions/0995f7b1-8deb-487a-8ec5-2c25a980fc8d/resourceGroups/Hyper-v-Test_group/providers/Microsoft.Compute/virtualMachines/Hyper-v-Test')
resource HypervTest 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: 'Hyper-v-Test'
  location: 'centralindia'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D4ds_v4'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-10'
        sku: '20h2-pro-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: 'Hyper-v-Test_OsDisk_1_8470d2d9392a4290a330cebe9bdb48d5'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: '/subscriptions/0995f7b1-8deb-487a-8ec5-2c25a980fc8d/resourceGroups/Hyper-v-Test_group/providers/Microsoft.Compute/disks/Hyper-v-Test_OsDisk_1_8470d2d9392a4290a330cebe9bdb48d5'
        }
        deleteOption: 'Detach'
        diskSizeGB: 127
      }
      dataDisks: [
        {
          lun: 0
          name: 'Images'
          createOption: 'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            storageAccountType: 'Premium_LRS'
            id: '/subscriptions/0995f7b1-8deb-487a-8ec5-2c25a980fc8d/resourceGroups/Hyper-v-Test_group/providers/Microsoft.Compute/disks/images'
          }
          deleteOption: 'Detach'
          diskSizeGB: 1024
          toBeDetached: false
        }
      ]
    }
    osProfile: {
      computerName: 'Hyper-v-Test'
      adminUsername: 'windowsadmin'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '/subscriptions/0995f7b1-8deb-487a-8ec5-2c25a980fc8d/resourceGroups/Hyper-v-Test_group/providers/Microsoft.Network/networkInterfaces/hyper-v-test913'
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Client'
  }
}
