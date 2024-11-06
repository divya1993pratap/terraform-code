resource "azurerm_resource_group" "RG_Block" {
    for_each = var.RG_Map
  name = each.value.name
  location = each.value.location
}