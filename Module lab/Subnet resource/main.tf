resource "azurerm_subnet" "Subnet_Block" {
    for_each = var.Subnet_variable
    name =each.value.Subnet_name
    virtual_network_name = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name
    address_prefixes = each.value.address_prefixes
  
}