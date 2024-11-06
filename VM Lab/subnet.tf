resource "azurerm_subnet" "Subnet_Block" {
  name                 = "VM-Subnet"
  resource_group_name  = azurerm_resource_group.RG_Block.name
  virtual_network_name = azurerm_virtual_network.VNET_Block.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "publicIP_Block" {
  name                = "VM-Public"
  resource_group_name = azurerm_resource_group.RG_Block.name
  location            = azurerm_resource_group.RG_Block.location
  allocation_method   = "Dynamic"
}