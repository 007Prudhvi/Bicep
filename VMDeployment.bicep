param adminUsername string

@secure()
param adminPassword string
param location string = resourceGroup().location

var virtualMachineName = 'AZBICEPVM001'
var nic1Name = 'NIC-1'
var nic2Name = 'NIC-2'
var virtualNetworkName = 'VNet'
var subnet1Name = 'SNet-1'
var subnet2Name = 'SNet-2'
var publicIPAddressName = '${virtualMachineName}-PIP'
var diagStorageAccountName = 'diags${uniqueString(resourceGroup().id)}'
var networkSecurityGroupName = 'NIC1-NSG'
var networkSecurityGroupName2 = 'NIC2-NSG'

// This is the virtual machine that you're building.
resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: virtualMachineName
  location: location
  properties: {
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${virtualMachineName}-OSDisk'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nic1.id
        }
        {
          properties: {
            primary: false
          }
          id: nic2.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagsAccount.properties.primaryEndpoints.blob
      }
    }
  }
}

resource diagsAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: diagStorageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

// Simple Network Security Group for subnet2
resource nsg2 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName2
  location: location
  properties: {}
}

// This will build a Virtual Network.
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsg2.id
          }
        }
      }
    ]
  }
}

// This will be your Primary NIC
resource nic1 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic1Name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/${subnet1Name}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

// This will be your Secondary NIC
resource nic2 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic2Name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/${subnet2Name}'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Public IP for your Primary NIC
resource pip 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Network Security Group (NSG) for your Primary NIC
resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

output hostname string = pip.properties.dnsSettings.fqdn
