module "foundation" {
  source = "../../../modules/foundation"

  management_group_name         = var.management_group_name
  management_group_display_name = var.management_group_display_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}