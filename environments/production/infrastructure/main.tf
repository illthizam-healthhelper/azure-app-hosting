module "foundation" {
  source = "../../../modules/foundation"

  management_group_name         = var.management_group_name
  management_group_display_name = var.management_group_display_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

module "vnet" {
  source = "../../../modules/networks"

  #Vnet config
  virtual_network_name = var.virtual_network_name
  resource_group_name  = module.foundation.resource_group_name
  location             = module.foundation.resource_group_location

  
  address_space = var.vnet_address_space
  subnets       = var.subnets

  #NSG config
  nsg_by_subnet = var.nsg_by_subnet

  #NAT config
  nat_public_ip_name = var.nat_public_ip_name
  nat_attach_subnets = var.nat_attach_subnets
  nat_gateway_name  = var.nat_gateway_name

  #Route table config
  route_table_by_subnet = var.route_table_by_subnet

  tags = var.tags
}