variable "management_group_name" {
  description = "Name of the Azure Management Group"
  type        = string
}

variable "management_group_display_name" {
  description = "Display name of the Azure Management Group"
  type        = string
}

variable "subscription_name" {
  description = "Name of the Azure subscription"
  type        = string
}

variable "billing_scope_id" {
  description = "Azure billing scope used to create the subscription"
  type        = string
  sensitive   = true
}

variable "workload" {
  description = "Subscription workload type"
  type        = string
  default     = "Production"
}

variable "resource_group_name" {
  description = "Name of the application Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags applied to Azure resources"
  type        = map(string)
  default     = {}
}