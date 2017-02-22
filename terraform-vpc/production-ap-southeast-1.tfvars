#Network Vars
common_name = "squarefoot-production"
domain = "production.squarefoot-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-squarefoot-production-singapore"

vpc_cidr = "10.39.0.0/20"
dopt = ["AmazonProvidedDNS","10.39.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.39.8.0/23","10.39.10.0/23"]
public_subnet_cidr_blocks = ["10.39.4.0/23","10.39.6.0/23"]
private_subnet_cidr_blocks = ["10.39.0.0/23","10.39.2.0/23"]

nat_subnet_supernet = "10.39.8.0/22"
public_subnet_supernet = "10.39.4.0/22"
private_subnet_supernet = "10.39.0.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"
