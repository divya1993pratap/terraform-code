module "Module_RG_Block" {
    source = "../../resourcegroup"
    RG_Map = var.Module_RG
          
}

module "Module_STG_Block" {
    source = "../../storageaccount"
    STG_Map= var.Module_STG
    depends_on = [ module.Module_RG_Block ]
  
}

module "Module_Container_Block" {
    source = "../../container"
    Container_Map= var.Module_Cont
  depends_on = [ module.Module_STG_Block ]
}

module "Module_Vnet_Block" {
    source = "../../Vnet resource"
   Vnet_Variable=var.Module_Vnet
   depends_on = [ module.Module_RG_Block ]
}

module "Module_Subnet_Block" {
  source = "../../Subnet resource"
  Subnet_variable=var.Module_Subnet
  depends_on = [ module.Module_Vnet_Block ]
}

