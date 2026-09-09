output "sql_server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_database_name" {
  value = azurerm_mssql_database.this.name
}

output "redis_hostname" {
  value = azurerm_redis_cache.this.hostname
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}
