module "foundation" {
  source = "../../../modules/foundation"

  management_group_name         = var.management_group_name
  management_group_display_name = var.management_group_display_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

module "vnet" {
  source = "../../../modules/vnet"

  virtual_network_name = var.virtual_network_name
  resource_group_name  = module.foundation.resource_group_name
  location             = module.foundation.resource_group_location

  address_space = var.vnet_address_space
  subnets       = var.subnets

  tags = var.tags
}