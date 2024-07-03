variable "rg_name" {
	
}
variable "subnet_name" {
	
}
variable "subnet_CIDR" {
	default = "10.0.1.0/24"
}
variable "vnet-name" {
	
}
variable "rg_location" {
	default = "East US"
}
variable "vm_name" {
	
}
variable "vm_size" {
	default = "Standard_B1s"
}
variable "storacc_name" {
	
}
variable "account_tier" {
	default = "Standard"
}
variable "replication_type" {
	default = "LRS"
}
variable "nic_name" {
	
}
variable "public_ip_name" {
	
}
variable "vnet_CIDR" {
	default = "10.0.0.0/16"
}
variable "boot_diagnostics_sa_type" {
  description = "(Optional) Storage account type for boot diagnostics"
  default     = "Standard_LRS"
}


