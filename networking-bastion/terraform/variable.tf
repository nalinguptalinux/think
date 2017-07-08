#For vpc Module
variable "region" { }
variable "vpc_cidr" { }
variable "common_name" { }
variable "domain_name" { }
variable "dns_name" { type = "list" }
variable "pub" { type = "list" }
variable "az" { type = "list" }
variable "priv" { type = "list" }

#For ec2 Module
variable "ami" { }
variable "instance_type" { }
variable "key_name" { }
