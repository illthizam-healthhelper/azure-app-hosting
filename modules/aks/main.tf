resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = var.dns_prefix
  sku_tier            = "Free"

  oidc_issuer_enabled       = true # required for Workload Identity federated credentials
  workload_identity_enabled = true

  default_node_pool {
    name           = "system"
    vm_size        = var.node_vm_size
    node_count     = var.node_count
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "cilium"
    network_data_plane  = "cilium"
  }

  # Restrict the public API server; leave empty to allow from anywhere (not recommended)
  dynamic "api_server_access_profile" {
    for_each = length(var.authorized_ip_ranges) > 0 ? [1] : []
    content {
      authorized_ip_ranges = var.authorized_ip_ranges
    }
  }

  tags = var.tags
}

# AcrPull for the cluster's kubelet identity so nodes can pull images without credentials
resource "azurerm_role_assignment" "acr_pull" {
  count                = var.acr_id != null ? 1 : 0
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
