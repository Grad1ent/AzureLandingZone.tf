locals {
    # Common
    prefix = var.prefix
    region = var.region

    # Resource groups
    rg_hub_name = "${var.prefix}Hub"
    rg_spoke_01_name = "${var.prefix}ML"
    rg_spoke_02_name = "${var.prefix}TF"

    resoure_group_names = [
        local.rg_hub_name,
        local.rg_spoke_01_name,
        local.rg_spoke_02_name
    ]

    # VNets
    



    # Tags
    tags = {
        "Data Classification"   = "Internal"
        "Service identifier"    = "Sample data engineering"
        "Service owner"         = "Wojciech Pazdzierkiewicz"
        "Technical contact"     = "wojciech@pazdzierkiewicz.pl"
        "Cost Center"           = "0000"
        "Regulatory Compliance" = "N/A"
    }


}