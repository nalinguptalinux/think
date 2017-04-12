#Network Vars
common_name = "ipropertymy-prod-sg"
domain = "prod.ipropertymy-sg.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-prod-sg"

vpc_cidr = "10.90.0.0/20"
dopt = ["AmazonProvidedDNS","10.90.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.0.0/23","10.90.2.0/23"]
public_subnet_cidr_blocks = ["10.90.4.0/23","10.90.6.0/23"]
private_subnet_cidr_blocks = ["10.90.8.0/23","10.90.10.0/23"]

nat_subnet_supernet = "10.90.0.0/22"
public_subnet_supernet = "10.90.4.0/22"
private_subnet_supernet = "10.90.8.0/22"
profile_custom_profile = "ipropertymyprod-sg"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

// Outputs:

// aws_vpc_id = vpc-daf196be
// bastion_public_ip = 52.221.175.36
// nat_subnets = subnet-5a41162c,subnet-be2301da
// private_subnets = subnet-9c4116ea,subnet-bd2301d9
// public_subnets = subnet-1d4f186b,subnet-bf2301db
// ssh_from_bastion_sg_id = sg-e0790187