#Network Vars
common_name = "ipropertymy-production"
domain = "production.ipropertymy-singapore.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-ipropertymy-production-tokyo"

vpc_cidr = "10.90.16.0/20"
dopt = ["AmazonProvidedDNS","10.90.16.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.90.24.0/23","10.90.26.0/23"]
public_subnet_cidr_blocks = ["10.90.20.0/23","10.90.22.0/23"]
private_subnet_cidr_blocks = ["10.90.16.0/23","10.90.18.0/23"]

nat_subnet_supernet = "10.90.24.0/22"
public_subnet_supernet = "10.90.20.0/22"
private_subnet_supernet = "10.90.16.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"

//Outputs:
//
