variable "resource_group_name" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "dns_zone_names" {
  description = "List of privatelink.* zone names to create and link"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
