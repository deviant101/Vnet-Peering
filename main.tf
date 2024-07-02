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