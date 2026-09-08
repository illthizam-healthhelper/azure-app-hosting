# envs/lab/backend.tf
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" }
    azuread = { source = "hashicorp/azuread", version = "~> 3.0" }
    random  = { source = "hashicorp/random",  version = "~> 3.6" }
  }
  backend "azurerm" {
    resource_group_name  = "terraform_state"
    storage_account_name = "azureterraformstoageacc"   # replace with your suffix
    container_name       = "tfstate"
    key                  = "production.terraform.tfstate"
    use_azuread_auth     = true                     # auth via your az login, no storage key
  }
}