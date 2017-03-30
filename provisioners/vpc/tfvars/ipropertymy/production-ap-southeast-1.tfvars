#Network Vars
common_name = "ipropertymy-production"
domain = "production.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-production-singapore"

vpc_cidr = "10.90.0.0/20"
dopt = ["AmazonProvidedDNS","10.90.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.8.0/23","10.90.10.0/23"]
public_subnet_cidr_blocks = ["10.90.4.0/23","10.90.6.0/23"]
private_subnet_cidr_blocks = ["10.90.0.0/23","10.90.2.0/23"]

nat_subnet_supernet = "10.90.8.0/22"
public_subnet_supernet = "10.90.4.0/22"
private_subnet_supernet = "10.90.0.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:

