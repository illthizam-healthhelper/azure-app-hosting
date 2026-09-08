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
output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}
output "subscription_name" {
  value = data.azurerm_subscription.current.display_name
}