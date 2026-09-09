variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "private_endpoint_subnet_id" {
  description = "snet-data subnet ID"
  type        = string
}

variable "sql_server_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "sql_admin_login" {
  type    = string
  default = "sqladminuser"
}

variable "sql_private_dns_zone_id" {
  type = string
}

variable "redis_name" {
  type = string
}

variable "redis_private_dns_zone_id" {
  type = string
}

variable "storage_account_name" {
  description = "Globally unique, lowercase, no hyphens, 3-24 chars"
  type        = string
}

variable "storage_private_dns_zone_id" {
  type = string
}

variable "key_vault_id" {
  description = "Key Vault ID to store the SQL connection string; null skips"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
