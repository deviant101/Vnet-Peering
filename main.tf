################## Resource Group ##################
resource "azurerm_resource_group" "peering" {
  name     = "peering-rg"
  location = var.location
}

###################### Vnet-A ######################
resource "azurerm_virtual_network" "A" {
  name                = "vnet-A"
  location            = "east us"
  resource_group_name = azurerm_resource_group.peering.name
  address_space       = ["10.5.0.0/16"]
}

################# Subnet in Vnet-A #################
resource "azurerm_subnet" "A-subnet" {
  name                 = "default-subnet"
  resource_group_name  = azurerm_resource_group.peering.name
  virtual_network_name = azurerm_virtual_network.A.name
  address_prefixes     = ["10.5.0.0/24"]
}

###################### Vnet-B ######################
resource "azurerm_virtual_network" "B" {
  name                = "vnet-B"
  location            = "central us"
  resource_group_name = azurerm_resource_group.peering.name
  address_space       = ["10.15.0.0/16"]
}

################# Subnet in Vnet-A #################
resource "azurerm_subnet" "B-subnet" {
  name                 = "default-subnet"
  resource_group_name  = azurerm_resource_group.peering.name
  virtual_network_name = azurerm_virtual_network.B.name
  address_prefixes     = ["10.15.0.0/24"]
}

##################### Peering from Vnet-A to Vnet-B #####################
resource "azurerm_virtual_network_peering" "A-to-B" {
  name                      = "A2B"
  resource_group_name       = azurerm_resource_group.peering.name
  virtual_network_name      = azurerm_virtual_network.A.name
  remote_virtual_network_id = azurerm_virtual_network.B.id
  # allow_virtual_network_access = true
  # allow_forwarded_traffic = true
  # allow_gateway_transit = true
  # use_remote_gateways = false

}

##################### Peering from Vnet-B to Vnet-A #####################
resource "azurerm_virtual_network_peering" "B-to-A" {
  name                      = "B2A"
  resource_group_name       = azurerm_resource_group.peering.name
  virtual_network_name      = azurerm_virtual_network.B.name
  remote_virtual_network_id = azurerm_virtual_network.A.id
  # allow_virtual_network_access = true
  # allow_forwarded_traffic = true
  # allow_gateway_transit = true
  # use_remote_gateways = false

}

##################### NIC #####################
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = azurerm_virtual_network.B.location
  resource_group_name = azurerm_virtual_network.B.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.B-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

####################### Public IP #######################
resource "azurerm_public_ip" "pip" {
  name                = "publicIP"
  location            = azurerm_virtual_network.B.location
  resource_group_name = azurerm_virtual_network.B.resource_group_name
  allocation_method   = "Static"
}

##################### Virtual Machine #####################
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vm"
  resource_group_name             = azurerm_virtual_network.B.resource_group_name
  location                        = azurerm_virtual_network.B.location
  size                            = "Standard_DS1_v2"
  network_interface_ids           = [azurerm_network_interface.nic.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  computer_name  = var.hostname
  admin_username = var.username
  admin_password = var.password
}

output "my_vm_public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}