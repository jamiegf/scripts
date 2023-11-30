


#refer to a subnet - get info from subnet to parse in this script
data "azurerm_subnet" "main_subnet" {
  name                 = var.main_subnet
  virtual_network_name = var.virtual_network
  resource_group_name  = var.resource_group
}

#data "azurerm_log_analytics_workspace" "example" {
#  name                = "loganalytics-we-sharedtest2"
#  resource_group = "rg-shared-westeurope-01"
#}

#######################

resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = "jgf-vmss"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = var.vm_size
  instances           = 1
  admin_password      = "Orange21!"
  admin_username      = "jamiegf"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      #subnet_id = azurerm_subnet.internal.id
       subnet_id = "${data.azurerm_subnet.main_subnet.id}"
    }
  }
}