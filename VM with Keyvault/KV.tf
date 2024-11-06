data "azurerm_client_config" "Client_Block" {}

resource "azurerm_key_vault" "KV_KV_Block" {
  name                       = "kv34343keyvault"
  location                   = "southindia"
  resource_group_name        = "kvrg"
  tenant_id                  = data.azurerm_client_config.Client_Block.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.Client_Block.tenant_id
    object_id = data.azurerm_client_config.Client_Block.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "KV_Secret_Block1" {
  name         = "username"
  value        = "admin123"
  key_vault_id = azurerm_key_vault.KV_KV_Block.id
}

resource "azurerm_key_vault_secret" "KV_Secret_Block2" {
  name         = "password"
  value        = "Admin@123456"
  key_vault_id = azurerm_key_vault.KV_KV_Block.id
}