#Network Vars
common_name = "squarefoot-development"
domain = "development.squarefoot-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-squarefoot-development-singapore"

vpc_cidr = "10.39.48.0/20"
dopt = ["AmazonProvidedDNS","10.39.48.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.39.56.0/23","10.39.58.0/23"]
public_subnet_cidr_blocks = ["10.39.52.0/23","10.39.54.0/23"]
private_subnet_cidr_blocks = ["10.39.48.0/23","10.39.50.0/23"]

nat_subnet_supernet = "10.39.56.0/22"
public_subnet_supernet = "10.39.52.0/22"
private_subnet_supernet = "10.39.48.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"