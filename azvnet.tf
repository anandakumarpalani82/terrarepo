terraform {
required_providers {
azurerm = {
    source = "hashicorp/azurerm"
    version = "3.43.0"
}  
}  
}
provider "azurerm" {
    features {}
}
resource "azurerm_resource_group" "RG1" {
  name     = "Ananda-RG-2"
  location = "WEST US"

  tags = {
    "Envornment" = "prod"
    "Prodcut" = "Webservers"
  }
}
resource "azurerm_virtual_network" "Vnet1" {
  name                = "az-prod-vn01"
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "az-prod-int-snet01"
    address_prefix = "10.0.1.0/24"
  }
}

  resource "azurerm_subnet" "snet2" {
  name                 = "az-prod-int-snet02"
  resource_group_name  = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = ["10.0.2.0/24"]

}
