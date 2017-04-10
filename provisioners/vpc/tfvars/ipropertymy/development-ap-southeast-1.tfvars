#Network Vars
common_name = "ipropertymy-development"
domain = "development.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-development-singapore"

vpc_cidr = "10.90.48.0/20"
dopt = ["AmazonProvidedDNS","10.90.48.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.56.0/23","10.90.58.0/23"]
public_subnet_cidr_blocks = ["10.90.52.0/23","10.90.54.0/23"]
private_subnet_cidr_blocks = ["10.90.48.0/23","10.90.50.0/23"]

nat_subnet_supernet = "10.90.56.0/22"
public_subnet_supernet = "10.90.52.0/22"
private_subnet_supernet = "10.90.48.0/22"
profile_custom_profile = "ipropertymydev"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:

//aws_vpc_id = vpc-4ee9762a
//bastion_public_ip = 13.228.10.227
//nat_subnets = subnet-0b7d317d,subnet-2fe2ba4b
//private_subnets = subnet-f57e3283,subnet-71e4bc15
//public_subnets = subnet-63783415,subnet-c4e2baa0
//ssh_from_bastion_sg_id = sg-0cbad36b

