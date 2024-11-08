resource "azurerm_network_security_group" "NSG_Block" {
  name                = "VM_NSG"
  location            = azurerm_resource_group.RG_Block.location
  resource_group_name = azurerm_resource_group.RG_Block.name

   security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22-90"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}