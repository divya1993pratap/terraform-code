resource "azurerm_virtual_network" "VNET_Block" {
  name                = "VM-VNET"
  location            = azurerm_resource_group.RG_Block.location
  resource_group_name = azurerm_resource_group.RG_Block.name
  address_space       = ["10.0.0.0/16"]
#   dns_servers         = ["10.0.0.4", "10.0.0.5"]

}