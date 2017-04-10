#Network Vars
common_name = "ipropertysg-development"
domain = "development.ipropertysg-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertysg-development-singapore"

vpc_cidr = "10.90.128.0/20"
dopt = ["AmazonProvidedDNS","10.90.128.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.128.0/23","10.90.130.0/23"]
public_subnet_cidr_blocks = ["10.90.132.0/23","10.90.134.0/23"]
private_subnet_cidr_blocks = ["10.90.136.0/23","10.90.140.0/23"]

nat_subnet_supernet = "10.90.128.0/22"
public_subnet_supernet = "10.90.132.0/22"
private_subnet_supernet = "10.90.136.0/22"
profile_custom_profile = "ipropertysqdev"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:

// aws_vpc_id = vpc-78bbdf1c
// bastion_public_ip = 13.228.16.166
// nat_subnets = subnet-b29cbcd6,subnet-f30c5885
// private_subnets = subnet-129cbc76,subnet-a70357d1
// public_subnets = subnet-b19cbcd5,subnet-17025661
// ssh_from_bastion_sg_id = sg-66d0af01




