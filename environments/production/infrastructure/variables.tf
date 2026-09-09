variable "subscription_id" {
  type        = string
  sensitive   = true
  description = "Subscription ID the azurerm provider deploys into"
}

variable "management_group_name" {
  type = string
}

variable "management_group_display_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "virtual_network_name" {
  type = string
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnets" {
  type    = map(list(string))
  default = {}
}
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}
variable "nsg_by_subnet" {
  description = "Map of subnet name => NSG name"
  type        = map(string)
  default     = {}
}
variable "nat_public_ip_name" {
  description = "Name of the NAT Gateway public IP"
  type        = string
}
variable "nat_attach_subnets" {
  description = "List of subnets to attach the NAT Gateway to"
  type        = list(string)
  default     = []
}

variable "route_table_by_subnet" {
  description = "Map of subnet name => Route Table name"
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_names" {
  type = list(string)
  default = [
    "privatelink.database.windows.net",
    "privatelink.redis.cache.windows.net",
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.azurecr.io",
  ]
}

variable "acr_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "aks_cluster_name" {
  type = string
}

variable "aks_dns_prefix" {
  type = string
}

variable "aks_authorized_ip_ranges" {
  type    = list(string)
  default = []
}

variable "workload_identity_name" {
  type = string
}

variable "k8s_namespace" {
  type    = string
  default = "default"
}

variable "k8s_service_account_name" {
  type    = string
  default = "azureshop-api"
}

variable "sql_server_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "redis_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}