provider "azurerm" {
    features {}
}


resource "azurerm_resource_group" "implement_1" {
    name = "${var.rg_name}"
    location = "${var.rg_location}"
  
}

#######################################

resource "azurerm_virtual_network" "implement_1" {
    name = "${var.vnet-name}"
    resource_group_name = azurerm_resource_group.implement_1.name
    location = azurerm_resource_group.implement_1.location
    address_space = ["${var.vnet_CIDR}"]

}

resource "azurerm_subnet" "implement_1" {
    name = "${var.subnet_name}"
    resource_group_name = azurerm_resource_group.implement_1.name
    virtual_network_name = azurerm_virtual_network.implement_1.name
    address_prefixes = ["${var.subnet_CIDR}"]

}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.public_ip_name}"
  resource_group_name = azurerm_resource_group.implement_1.name
  location            = azurerm_resource_group.implement_1.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "implement_1" {
    name = "${var.nic_name}"
    resource_group_name = azurerm_resource_group.implement_1.name
    location = azurerm_resource_group.implement_1.location
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.implement_1.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.public_ip.id
    }
    

}

##########################################



resource "azurerm_storage_account" "implement_1" {
  name                     = "${var.storacc_name}"
  resource_group_name = azurerm_resource_group.implement_1.name
  location            = azurerm_resource_group.implement_1.location
  account_tier             = "${var.account_tier}"   #"Standard"     
account_replication_type = "${var.replication_type}"   #"LRS" 
}

############################################

resource "azurerm_virtual_machine" "implement_1" {
    name = "${var.vm_name}"
    resource_group_name = azurerm_resource_group.implement_1.name
  location            = azurerm_resource_group.implement_1.location
    
    vm_size = "${var.vm_size}"   #"Standard_B1s"
    os_profile_linux_config {
      disable_password_authentication = true
        ssh_keys {
            key_data = file("./ansible-master.pub")
            path = "/home/ubuntu/.ssh/authorized_keys"
        }
        }
    os_profile {
    computer_name  = "hostname"
    admin_username = "ubuntu"
    admin_password = "Password1234!"
  }
    network_interface_ids = [azurerm_network_interface.implement_1.id]
    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
    }
    storage_os_disk {
      name = "vidamuyarchi1-osdisk"
      caching = "ReadWrite"
      managed_disk_type = "Standard_LRS"
      disk_size_gb = 30
      create_option = "FromImage"
    }
    boot_diagnostics {
        enabled = "true"
        storage_uri = "${azurerm_storage_account.implement_1.primary_blob_endpoint}"
    }
  
}


