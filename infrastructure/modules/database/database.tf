resource "random_password" "admin_password" {
  length  = 16
  special = true
}

resource "random_password" "database_password" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  value        = random_password.admin_password.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "database_password" {
  name         = "database-password"
  value        = random_password.database_password.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                          = "${var.project_name}-postgresql-${var.unique_suffix}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "14"
  administrator_login           = var.admin_username
  administrator_password        = azurerm_key_vault_secret.admin_password.value
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = false
  sku_name                      = "GP_Standard_D2s_v3"
  storage_mb                    = 32768
  storage_tier                  = "P4"
  zone                          = "2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
