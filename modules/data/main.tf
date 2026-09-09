resource "random_password" "sql_admin" {
  length      = 20
  special     = true
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}

resource "azurerm_mssql_server" "this" {
  name                           = var.sql_server_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  version                        = "12.0"
  administrator_login            = var.sql_admin_login
  administrator_login_password   = random_password.sql_admin.result
  public_network_access_enabled  = false

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name        = var.sql_database_name
  server_id   = azurerm_mssql_server.this.id
  sku_name    = "Basic"
  max_size_gb = 2

  tags = var.tags
}

resource "azurerm_private_endpoint" "sql" {
  name                = "pe-${var.sql_server_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.sql_server_name}"
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.sql_private_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_redis_cache" "this" {
  name                           = var.redis_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  capacity                       = 0
  family                         = "C"
  sku_name                       = "Basic"
  public_network_access_enabled  = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "redis" {
  name                = "pe-${var.redis_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.redis_name}"
    private_connection_resource_id = azurerm_redis_cache.this.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.redis_private_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage" {
  name                = "pe-${var.storage_account_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.storage_account_name}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.storage_private_dns_zone_id]
  }

  tags = var.tags
}

# Password lives only in Terraform state and Key Vault — never in Git or a manifest
resource "azurerm_key_vault_secret" "sql_connection_string" {
  count        = var.key_vault_id != null ? 1 : 0
  name         = "sql-connection-string"
  key_vault_id = var.key_vault_id
  value        = "Server=tcp:${azurerm_mssql_server.this.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.this.name};User ID=${var.sql_admin_login};Password=${random_password.sql_admin.result};Encrypt=true;"
}
