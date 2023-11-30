resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'jamiegf_storage123'
  sku: {
    name: 'Standard_LRS'
  }
  kind:'StorageV2'
  location: 'uksouth'
}
