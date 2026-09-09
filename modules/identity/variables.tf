variable "identity_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "oidc_issuer_url" {
  description = "AKS cluster OIDC issuer URL; null skips federated credential creation"
  type        = string
  default     = null
}

variable "k8s_namespace" {
  type    = string
  default = "default"
}

variable "k8s_service_account_name" {
  type    = string
  default = "azureshop-api"
}

variable "key_vault_id" {
  description = "Key Vault ID to grant Secrets User role; null skips"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
