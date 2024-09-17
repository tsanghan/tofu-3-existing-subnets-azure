# Define local variables
locals {
  name     = "tsanghan" #change me
  vpc_cidr = "10.0.0.0/16"
  location = "southeastasia"
  common_tags = {
    environment = "dev"
    project     = "Troubleshooting Azure ARM Template"
  }

}

data "http" "myip" {
  url = "http://api.ipify.org"
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "random_id" "key_vault" {
  prefix = "f5"
  byte_length = 3
}

resource "random_id" "secret" {
  byte_length = 10
}

resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "${local.name}-${random_id.rg_name.hex}-rg"
}

# resource "azurerm_ssh_public_key" "example" {
#   name                = "tsanghan-sshkey"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = local.location
#   public_key          = file("id_rsa.pub")
# }

resource "azurerm_network_security_group" "nsg1" {
  location            = var.vnet_location
  name                = "${local.name}-${random_id.rg_name.hex}-nsg"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_route_table" "rt1" {
  location            = var.vnet_location
  name                = "${local.name}-${random_id.rg_name.hex}-rt"
  resource_group_name = azurerm_resource_group.example.name
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "4.1.0"
  resource_group_name = azurerm_resource_group.example.name
  use_for_each        = var.use_for_each
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
  vnet_location       = var.vnet_location

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }

  tags = merge(local.common_tags, {
    costcenter = "training"
  })

}