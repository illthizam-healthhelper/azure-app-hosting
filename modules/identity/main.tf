resource "azurerm_user_assigned_identity" "workload" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Links AKS's OIDC issuer to this identity for the given pod's ServiceAccount
resource "azurerm_federated_identity_credential" "workload" {
  count               = var.oidc_issuer_url != null ? 1 : 0
  name                = "fed-${var.identity_name}"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.workload.id
  issuer              = var.oidc_issuer_url
  audience            = ["api://AzureADTokenExchange"]
  subject             = "system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"
}

resource "azurerm_role_assignment" "key_vault_secrets_user" {
  count                = var.key_vault_id != null ? 1 : 0
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
}
