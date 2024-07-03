terraform {
  backend "azurerm" {
    resource_group_name = "rg01-b01"
    storage_account_name = "imp1storageacc"
    container_name = "terraformstate"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
}

module "ansible_node_01" {
    source = "./files"
    vm_name = "ansiblenode0103jul"
    public_ip_name = "ansiblenode01pip"
    nic_name = "ansiblenode01nic"
    storacc_name = "ansiblenode01storacc"
    vnet-name = "ansiblenode01vnet"
    subnet_name = "ansiblenode01subnet"
    rg_name = "ansiblenode01rg"
  
}

module "ansible_master_03jul" {
    source = "./files"
    vm_name = "ansiblemaster03jul"
    public_ip_name = "ansiblemasterpip"
    nic_name = "ansiblemasternic"
    storacc_name = "ansiblemasterstoracc"
    vnet-name = "ansiblemastervnet"
    subnet_name = "ansiblemastersubnet"
    rg_name = "ansiblemasterrg"
  
}

module "ansible_node_02" {
    source = "./files"
    vm_name = "ansiblenode0203jul"
    public_ip_name = "ansiblenode02pip"
    nic_name = "ansiblenode02nic"
    storacc_name = "ansiblenode02storacc"
    vnet-name = "ansiblenode02vnet"
    subnet_name = "ansiblenode02subnet"
    rg_name = "ansiblenode02rg"
  
}

module "ansible_node_03" {
  source = "./files"  
  vm_name = "ansiblenode0303jul"
  public_ip_name = "ansiblenode03pip"
    nic_name = "ansiblenode03nic"
    storacc_name = "ansiblenode03storacc"
    vnet-name = "ansiblenode03vnet"
    subnet_name = "ansiblenode03subnet"
    rg_name = "ansiblenode03rg"
}