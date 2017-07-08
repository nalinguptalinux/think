variable "region" { }
variable "vpc_cidr" { }
variable "common_name" { }
variable "domain_name" { }
variable "dns_name" { type = "list" }
variable "pub" { type = "list" }
variable "az" { type = "list" }
variable "priv" { type = "list" }
variable "key_name" { }
