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