variable "vm" {
  default = "virtual-machine"
}
variable "resource_group" {
  default = "tf_ResourceGroup"
}
variable "location" {
  default = "uksouth"
}
variable "virtual_network" {
  default = "tf-jamiegf-vnet"
}
variable "main_subnet" {
  default = "tf_main_subnet"
  description = "blah blah"
  type = string
}
variable "ss_subnet" {
  default = "tf_scale_set_subnet"
}

variable "bastion_subnet" {
  default = "bastion_subnet"
}
variable "vm_size" {
  default = "Standard_DS1_v2"
}