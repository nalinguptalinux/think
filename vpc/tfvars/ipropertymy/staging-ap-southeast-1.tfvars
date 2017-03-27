#Network Vars
common_name = "ipropertymy-staging"
domain = "staging.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-staging-singapore"

vpc_cidr = "10.90.32.0/20"
dopt = ["AmazonProvidedDNS","10.90.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.40.0/23","10.90.42.0/23"]
public_subnet_cidr_blocks = ["10.90.36.0/23","10.90.38.0/23"]
private_subnet_cidr_blocks = ["10.90.32.0/23","10.90.34.0/23"]

nat_subnet_supernet = "10.90.40.0/22"
public_subnet_supernet = "10.90.36.0/22"
private_subnet_supernet = "10.90.32.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//

