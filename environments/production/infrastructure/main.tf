module "foundation" {
  source = "../../../modules/foundation"

  management_group_name         = var.management_group_name
  management_group_display_name = var.management_group_display_name

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

module "vnet" {
  source = "../../../modules/networks"

  #Vnet config
  virtual_network_name = var.virtual_network_name
  resource_group_name  = module.foundation.resource_group_name
  location             = module.foundation.resource_group_location

  
  address_space = var.vnet_address_space
  subnets       = var.subnets

  #NSG config
  nsg_by_subnet = var.nsg_by_subnet

  #NAT config
  nat_public_ip_name = var.nat_public_ip_name
  nat_attach_subnets = var.nat_attach_subnets
  nat_gateway_name  = var.nat_gateway_name

  #Route table config
  route_table_by_subnet = var.route_table_by_subnet

  tags = var.tags
}

module "private_dns" {
  source = "../../../modules/private-dns"

  resource_group_name = module.foundation.resource_group_name
  virtual_network_id  = module.vnet.virtual_network_id
  dns_zone_names      = var.private_dns_zone_names

  tags = var.tags
}

module "acr" {
  source = "../../../modules/acr"

  registry_name       = var.acr_name
  resource_group_name = module.foundation.resource_group_name
  location            = module.foundation.resource_group_location

  tags = var.tags
}

module "keyvault" {
  source = "../../../modules/keyvault"

  key_vault_name             = var.key_vault_name
  resource_group_name        = module.foundation.resource_group_name
  location                   = module.foundation.resource_group_location
  private_endpoint_subnet_id = module.vnet.subnet_ids["snet-data"]
  private_dns_zone_id        = module.private_dns.zone_ids["privatelink.vaultcore.azure.net"]

  tags = var.tags
}

module "aks" {
  source = "../../../modules/aks"

  cluster_name         = var.aks_cluster_name
  resource_group_name  = module.foundation.resource_group_name
  location             = module.foundation.resource_group_location
  dns_prefix           = var.aks_dns_prefix
  subnet_id            = module.vnet.subnet_ids["snet-aks"]
  authorized_ip_ranges = var.aks_authorized_ip_ranges
  acr_id               = module.acr.acr_id

  tags = var.tags
}

module "identity" {
  source = "../../../modules/identity"

  identity_name            = var.workload_identity_name
  resource_group_name      = module.foundation.resource_group_name
  location                 = module.foundation.resource_group_location
  oidc_issuer_url          = module.aks.oidc_issuer_url
  k8s_namespace            = var.k8s_namespace
  k8s_service_account_name = var.k8s_service_account_name
  key_vault_id             = module.keyvault.key_vault_id

  tags = var.tags
}

module "data" {
  source = "../../../modules/data"

  resource_group_name        = module.foundation.resource_group_name
  location                   = module.foundation.resource_group_location
  private_endpoint_subnet_id = module.vnet.subnet_ids["snet-data"]

  sql_server_name         = var.sql_server_name
  sql_database_name       = var.sql_database_name
  sql_private_dns_zone_id = module.private_dns.zone_ids["privatelink.database.windows.net"]

  redis_name                = var.redis_name
  redis_private_dns_zone_id = module.private_dns.zone_ids["privatelink.redis.cache.windows.net"]

  storage_account_name        = var.storage_account_name
  storage_private_dns_zone_id = module.private_dns.zone_ids["privatelink.blob.core.windows.net"]

  key_vault_id = module.keyvault.key_vault_id

  tags = var.tags
}