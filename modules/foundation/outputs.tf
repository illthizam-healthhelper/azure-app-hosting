output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_location" {
  value = azurerm_resource_group.this.location
}
output "management_group_name" {
  value = azurerm_management_group.this.name
}
output "management_group_display_name" {
  value = azurerm_management_group.this.display_name
}
output "subscription_name" {
  value = azurerm_subscription.this.subscription_name
}
output "billing_scope_id" {
  value = azurerm_subscription.this.billing_scope_id
}
output "workload" {
  value = azurerm_subscription.this.workload
}