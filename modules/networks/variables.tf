variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group the VNet is created in"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnet name => address prefixes"
  type        = map(list(string))
  default     = {}
}

variable "tags" {
  description = "Tags applied to Azure resources"
  type        = map(string)
  default     = {}
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
  description = "Map of subnet name => Route Table name, forces deny-internet on that subnet"
  type        = map(string)
  default     = {}
}