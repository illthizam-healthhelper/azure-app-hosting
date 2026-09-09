variable "registry_name" {
  description = "Globally unique ACR name, alphanumeric only"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  description = "Basic is always-on cost tier; Premium required for Private Link"
  type        = string
  default     = "Basic"
}

variable "tags" {
  type    = map(string)
  default = {}
}
