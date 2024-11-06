resource "azurerm_virtual_network" "Vnet_Block" {
    for_each = var.Vnet_Variable
    name=each.value.Vnet_name
    resource_group_name =each.value.resource_group_name
    location = each.value.location
    address_space = each.value.address_space
  
}