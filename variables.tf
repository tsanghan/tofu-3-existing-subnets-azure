variable "location" {
  type    = string
  default = "southeastasia"
}

variable "use_for_each" {
  type    = bool
  default = true
}

variable "vnet_location" {
  type    = string
  default = "southeastasia"
}

variable "bigIpImage" {
  type    = string
  default = "f5-networks:f5-big-ip-good:f5-bigip-virtual-edition-25m-good-hourly:17.1.100002"
}

variable "provisionPublicIpMgmt" {
  type    = bool
  default = true
}

variable "provisionServicePublicIp" {
  type    = bool
  default = true
}