output "ResourceGroup_name" {
  value = azurerm_resource_group.example.name
}

output "bigIpMgmtSubnetId" {
  value = lookup(module.vnet.vnet_subnets_name_id, "subnet1", "No Subnet ID")
}

output "bigIpExternalSubnetId" {
  value = lookup(module.vnet.vnet_subnets_name_id, "subnet2", "No Subnet ID")
}

output "bigIpInternalSubnetId" {
  value = lookup(module.vnet.vnet_subnets_name_id, "subnet3", "No Subnet ID")
}

output "uniqueString" {
  value = random_id.key_vault.hex
}

output "sshKey" {
  value = file("./id_ed25519.pub")
}

output "bigIpPasswordSecretValue" {
  value = random_id.secret.hex
}

output "restrictedSrcAddressApp" {
  value = data.http.myip.response_body
}

output "restrictedSrcAddressMgmt" {
  value = data.http.myip.response_body
}

output "bigIpImage" {
  value = var.bigIpImage
}

output "provisionServicePublicIp" {
  value = true
}

output "provisionPublicIpMgmt" {
  value = true
}