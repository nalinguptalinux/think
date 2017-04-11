#Network Vars
common_name = "ipropertysg-staging"
domain = "staging.ipropertysg-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertysg-staging-singapore"

vpc_cidr = "10.90.144.0/20"
dopt = ["AmazonProvidedDNS","10.90.144.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.144.0/23","10.90.146.0/23"]
public_subnet_cidr_blocks = ["10.90.148.0/23","10.90.150.0/23"]
private_subnet_cidr_blocks = ["10.90.152.0/23","10.90.154.0/23"]

nat_subnet_supernet = "10.90.144.0/22"
public_subnet_supernet = "10.90.148.0/22"
private_subnet_supernet = "10.90.152.0/22"
profile_custom_profile = "ipropertysgstaging"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

// Outputs:

// aws_vpc_id = vpc-061b7c62
// bastion_public_ip = 52.74.126.248
// nat_subnets = subnet-e7c0e383,subnet-57affb21
// private_subnets = subnet-c3c7e4a7,subnet-94acf8e2
// public_subnets = subnet-1ec5e67a,subnet-06affb70
// ssh_from_bastion_sg_id = sg-01295066




