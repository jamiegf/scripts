

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
    location = var.location
    tags = {
    Environment = "Terraform jamiegf environment"
    Team = "DevOps"
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name         =       var.virtual_network
    address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}
#NAT Gateway ******************************************

#create NGW IP address
resource "azurerm_public_ip" "ngw_ip" {
  name                = "nat-gateway-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  #zones               = ["1"]
}

#create nat gateway
resource "azurerm_nat_gateway" "ngw" {
  name                = "tf-natgateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  #zones                   = ["1"]
}
#associate NGW IP with nat Gatewat
resource "azurerm_nat_gateway_public_ip_association" "ngw_ngw_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.ngw.id
  public_ip_address_id = azurerm_public_ip.ngw_ip.id
}

#create subnets *************************************
######################################################
resource "azurerm_subnet" "main_subnet" {
  name                 = var.main_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
#associate ngw
resource "azurerm_subnet_nat_gateway_association" "main_subnet_association" {
  subnet_id      = azurerm_subnet.main_subnet.id
  nat_gateway_id = azurerm_nat_gateway.ngw.id
}

# create scale set subnet************
resource "azurerm_subnet" "ss_subnet" {
  name                 = var.ss_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.7.0/24"]
}
#associate ngw
resource "azurerm_subnet_nat_gateway_association" "ss_subnet_association" {
  subnet_id      = azurerm_subnet.ss_subnet.id
  nat_gateway_id = azurerm_nat_gateway.ngw.id
}
# create bastion subnet************
resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet" #var.bastion_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.55.0/24"]

}

#create Bastion Ip
resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
#create Bastion Service
resource "azurerm_bastion_host" "bastion_host" {
  name                = "bastion_host"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}