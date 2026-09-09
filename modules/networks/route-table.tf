resource "azurerm_route_table" "this" {
  for_each            = var.route_table_by_subnet
  name                = each.value
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "deny_internet" {
  for_each = var.route_table_by_subnet

  name                   = "deny-internet"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.this[each.key].name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "None"
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = var.route_table_by_subnet

  subnet_id      = azurerm_subnet.this[each.key].id
  route_table_id = azurerm_route_table.this[each.key].id
}
