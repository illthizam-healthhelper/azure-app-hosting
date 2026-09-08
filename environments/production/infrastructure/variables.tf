variable "subscription_id" {
  sensitive   = true
  type        = string
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