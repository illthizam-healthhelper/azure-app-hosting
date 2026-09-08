variable "management_group_name" {
  type = string
}

variable "management_group_display_name" {
  type = string
}

variable "subscription_name" {
  type = string
}

variable "billing_scope_id" {
  type = string
}

variable "workload" {
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