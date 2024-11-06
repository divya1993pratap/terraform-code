resource "azurerm_resource_group" "KV_RG_Block" {
  location = "southindia"
  name     = "kvrg"
}

resource "azurerm_virtual_network" "KV_Vnet_Block" {
  name                = "kvvnet"
  resource_group_name = "kvrg"
  location            = "southindia"
  address_space       = ["10.0.0.0/16"]
  depends_on          = [azurerm_resource_group.KV_RG_Block]
}

resource "azurerm_subnet" "KV_Sub_Block" {
  name                 = "kvsub"
  virtual_network_name = "kvvnet"
  resource_group_name  = "kvrg"
  address_prefixes     = ["10.0.0.0/24"]
  depends_on           = [azurerm_virtual_network.KV_Vnet_Block]
}
resource "azurerm_subnet" "KV_Sub_Block1" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "kvvnet"
  resource_group_name  = "kvrg"
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_virtual_network.KV_Vnet_Block]
}

resource "azurerm_public_ip" "KV_PIP_Block" {
  name                = "kvpip"
  resource_group_name = "kvrg"
  location            = "southindia"
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on          = [azurerm_resource_group.KV_RG_Block]

}
resource "azurerm_bastion_host" "KV_Bas_Block" {
  name                = "kvbastion"
  resource_group_name = "kvrg"
  location            = "southindia"

  ip_configuration {
    name                 = "kvipconfig"
    subnet_id            = azurerm_subnet.KV_Sub_Block1.id
    public_ip_address_id = azurerm_public_ip.KV_PIP_Block.id
  }
}

resource "azurerm_network_interface" "KV_NIC_Block" {
  name                = "kvnic"
  location            = "southindia"
  resource_group_name = "kvrg"

  ip_configuration {
    name                          = "kvnicipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.KV_Sub_Block.id
  }
}

resource "azurerm_linux_virtual_machine" "KV_VM_Block" {
  name                            = "kvvm"
  resource_group_name             = "kvrg"
  location                        = "southindia"
  size                            = "Standard_F2"
  admin_username                  = azurerm_key_vault_secret.KV_Secret_Block1.value
  admin_password                  = azurerm_key_vault_secret.KV_Secret_Block2.value
  disable_password_authentication = "false"
  network_interface_ids           = [azurerm_network_interface.KV_NIC_Block.id]



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
}