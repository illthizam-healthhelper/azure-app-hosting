resource "azurerm_management_group" "this" {
  name         = var.management_group_name
  display_name = var.management_group_display_name
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_subscription" "this" {
  subscription_name = var.subscription_name
  billing_scope_id  = var.billing_scope_id

  workload = var.workload
}
resource "azurerm_management_group_subscription_association" "this" {
  management_group_id = azurerm_management_group.this.id
  subscription_id     = azurerm_subscription.this.id
}