module "rg_module" {
  source          = "../Child/Resorce_Group"
  rgchildvariable = var.rg_parent
}

module "virtual_network_module" {
  depends_on      = [module.rg_module]
  source          = "../Child/Vnet"
  vnetchildvariable = var.Virtual_Network_Parent
}

module "subnet_module" {
  depends_on      = [module.virtual_network_module]
  source          = "../Child/Subnet"
  subnetchildvariable = var.subnet_parent
}
