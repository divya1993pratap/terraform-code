resource "azurerm_storage_account" "example" {
    for_each = var.RG-Storage
  name                     = each.value.stg-name
  resource_group_name      = each.value.RG_name
  location                 = each.value.location 
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  depends_on = [ azurerm_resource_group.Myrg ]
}