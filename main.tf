terraform {
  backend "azurerm" {
    key                  = "snackingnextgen-dev-comp-eastus2.tfstate"
    resource_group_name  = "ODDA-TFSTATE-DEV-RG"
    storage_account_name = "oddatfstateeus2devsa"
    container_name       = "resource-tfstate"
  }
}


//IF IT IS FOR LOCAL USE ONLY WHAT IS PURPOSE OF THE BLOCK?
//The step - name: terraform init put all the modules in the same context by copying /.github/templates/aks/ to this working dir

locals {
  r4       = r4
  region              = "eastus2"
  environment         = "dev"
  vnet_name           = "oddacoreeus2devvnet"
  vnet_rg             = "ODDACORE-NETWORK-EUS2-DEV-RG"
  resource_group_name = ""
}


module "kubernetes" {
  // Clonning module over HTTPS.
  source                        = "git@github.com/Mars-DNA/DNA-Central-Deployment.git//_modules/kubernetes-cluster?ref=main"
  tags                          = module.solution_settings.tags
  solution_settings             = module.solution_settings.settings
  providers = {
    azurerm.remote = azurerm.remote
  }
  depends_on = [
    azurerm_resource_group.kubernetes
  ]
}
