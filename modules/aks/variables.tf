variable "cluster_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "subnet_id" {
  description = "snet-aks subnet ID (NAT-attached, no public IP)"
  type        = string
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "authorized_ip_ranges" {
  description = "CIDRs allowed to reach the public API server, e.g. your home IP /32"
  type        = list(string)
  default     = []
}

variable "acr_id" {
  description = "ACR resource ID to grant AcrPull to the kubelet identity"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
