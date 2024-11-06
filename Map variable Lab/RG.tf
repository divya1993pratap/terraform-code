resource "azurerm_resource_group" "Myrg" {
    for_each = var.RG-map
  name     = each.value.RG-Name
  location = each.value.RG-Location
}