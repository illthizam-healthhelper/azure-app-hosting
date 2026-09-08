variable "management_group_name" {
  description = "Name of the Azure Management Group"
  type        = string
}

variable "management_group_display_name" {
  description = "Display name of the Azure Management Group"
  type        = string
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