resource "azurerm_private_dns_zone" "this" {
  for_each            = toset(var.dns_zone_names)
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Zone must be linked to the VNet or Private Endpoint DNS records never resolve
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = azurerm_private_dns_zone.this

  name                  = "link-${each.value.name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = each.value.name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = false
  tags                  = var.tags
}
