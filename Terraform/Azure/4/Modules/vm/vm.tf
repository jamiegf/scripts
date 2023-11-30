


#refer to a subnet - get info from subnet to parse in this script
data "azurerm_subnet" "main_subnet" {
  name                 = var.main_subnet
  virtual_network = var.virtual_network
  resource_group  = var.resource_group
}

resource "azurerm_network_interface" "vm-nic" {
  name                = "vm-nic"
  location            = var.location
  resource_group = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${data.azurerm_subnet.main_subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm
  resource_group = var.resource_group
  location            = var.location
  size                = var.vm_size
  admin_username      = "jamiegf"
  admin_password      = "Orange21!"
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}