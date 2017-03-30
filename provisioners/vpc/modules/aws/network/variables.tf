variable "common_name" { }
variable "region" { }
variable "domain" { }
variable "key_name" { }
variable "vpc_cidr" { }
variable "dopt" { type = "list" }
variable "zones" { type = "list" }
variable "nat_subnet_cidr_blocks" { type = "list" }
variable "public_subnet_cidr_blocks" { type = "list" }
variable "private_subnet_cidr_blocks" { type = "list" }
variable "nat_subnet_supernet" { }
variable "public_subnet_supernet" { }
variable "private_subnet_supernet" { }
