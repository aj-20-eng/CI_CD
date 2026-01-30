param location string = 'eastus'
param aksName string = 'demo-aks-poc1'
param dnsPrefix string = 'demoaksdns'
param nodeCount int = 1
param vmSize string = 'Standard_D2s_v3' // 2 CPU, 4GB

resource aks 'Microsoft.ContainerService/managedClusters@2023-01-02-preview' = {
  name: aksName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix

    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: nodeCount
        vmSize: vmSize
        osType: 'Linux'
        mode: 'System'
        enableAutoScaling: false
        type: 'VirtualMachineScaleSets'
      }
    ]

    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
      outboundType: 'loadBalancer'
    }

    apiServerAccessProfile: {
      enablePrivateCluster: false
    }
  }
}
