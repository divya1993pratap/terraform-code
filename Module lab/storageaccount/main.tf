resource "azurerm_storage_account" "STG_Block" {
    for_each = var.STG_Map
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.RG-Name
    account_tier = each.value.account
    account_replication_type = each.value.account_replication_type
}