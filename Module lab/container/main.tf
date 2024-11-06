resource "azurerm_storage_container" "name" {
    for_each = var.Container_Map
    name = each.value.Container_name
    storage_account_name = each.value.STG_name  
}