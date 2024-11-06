resource "azurerm_resource_group" "App_RG_Block" {
    name="Netflix_RG"
    location = "westus"  
}
resource "azurerm_virtual_network" "App_Vnet_Block" {
  name="Netflix_Vnet"
  resource_group_name = "Netflix_RG"
  location = "westus"
  address_space = ["10.0.0.0/16"]
  depends_on = [ azurerm_resource_group.App_RG_Block ]
}
resource "azurerm_subnet" "App_Subnet_Block" {
    name="netflix_Subnet"
    resource_group_name = "Netflix_RG"
    virtual_network_name = "Netflix_Vnet"
    address_prefixes = ["10.0.1.0/24"]
    depends_on = [ azurerm_virtual_network.App_Vnet_Block ]
  
}
resource "azurerm_public_ip" "App_PIP_Block" {
    name="Netflix_PublicIP"
    resource_group_name = "Netflix_RG"
  location = "westus"
  allocation_method = "Static"
  depends_on = [ azurerm_resource_group.App_RG_Block ]
}
resource "azurerm_network_interface" "App_NIC_Block" {
    name="Netflix_NIC"
    resource_group_name = "Netflix_RG"
  location = "westus"
  depends_on = [ azurerm_resource_group.App_RG_Block ]
  ip_configuration {
    name = "Netflix_IP_Config"
private_ip_address_allocation ="Dynamic"
subnet_id = azurerm_subnet.App_Subnet_Block.id
public_ip_address_id = azurerm_public_ip.App_PIP_Block.id
  } 
   
}

resource "azurerm_linux_virtual_machine" "App_VM" {
  name="NetflixVM"
  resource_group_name = "Netflix_RG"
  location = "westus"
  network_interface_ids = [azurerm_network_interface.App_NIC_Block.id]
  admin_username = "Admin@123456"
  admin_password = "Admin@9758888776"
  size = "Standard_F2"
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  disable_password_authentication = "false"
}