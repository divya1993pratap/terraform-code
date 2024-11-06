resource "azurerm_virtual_machine" "VM_Block" {
  name                  = "DevopsVM"
  location              = azurerm_resource_group.RG_Block.location
  resource_group_name   = azurerm_resource_group.RG_Block.name
  network_interface_ids = [azurerm_network_interface.NIC_Block.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "VMdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Devops"
    admin_username = "Admin123"
    admin_password = "Admin@902606"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  
}
}