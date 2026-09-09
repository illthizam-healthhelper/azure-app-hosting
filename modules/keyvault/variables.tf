variable "key_vault_name" {
  description = "Globally unique Key Vault name, 3-24 chars"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  description = "ID of the privatelink.vaultcore.azure.net zone"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
