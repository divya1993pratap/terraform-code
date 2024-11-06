resource "azurerm_network_interface" "NIC_Block" {
  name                = "VM-NIC"
  location            = azurerm_resource_group.RG_Block.location
  resource_group_name = azurerm_resource_group.RG_Block.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subnet_Block.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id= azurerm_public_ip.publicIP_Block.id

  }
}

