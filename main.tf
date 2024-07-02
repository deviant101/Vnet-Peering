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