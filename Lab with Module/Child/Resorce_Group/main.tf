resource "azurerm_resource_group" "RG_block" {
  for_each = var.rgchildvariable
  name     = each.value.name
  location = each.value.location
}