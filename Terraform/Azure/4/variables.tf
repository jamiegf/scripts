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
}
variable "ss_subnet" {
  default = "tf_scale_set_subnet"
}

variable "bastion_subnet" {
  default = "bastion_subnet"
}