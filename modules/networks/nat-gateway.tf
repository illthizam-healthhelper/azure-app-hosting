resource "azurerm_nat_gateway" "this" {
  name                    = "${var.nat_gateway_name}-nat"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_public_ip" "nat" {
  name                = "${var.nat_public_ip_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = toset(var.nat_attach_subnets)

  subnet_id      = azurerm_subnet.this[each.value].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}