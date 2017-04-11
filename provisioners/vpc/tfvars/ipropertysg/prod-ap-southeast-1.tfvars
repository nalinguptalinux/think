#Network Vars
common_name = "ipropertysg-prod-sg"
domain = "prod.ipropertysg-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertysg-prod-singapore"

vpc_cidr = "10.90.160.0/20"
dopt = ["AmazonProvidedDNS","10.90.160.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.160.0/23","10.90.162.0/23"]
public_subnet_cidr_blocks = ["10.90.164.0/23","10.90.166.0/23"]
private_subnet_cidr_blocks = ["10.90.168.0/23","10.90.170.0/23"]

nat_subnet_supernet = "10.90.160.0/22"
public_subnet_supernet = "10.90.164.0/22"
private_subnet_supernet = "10.90.168.0/22"
profile_custom_profile = "ipropertysgprod-sg"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"


// Outputs:

// aws_vpc_id = vpc-3a6f085e
// bastion_public_ip = 52.221.175.96
// nat_subnets = subnet-cdd682bb,subnet-caceedae
// private_subnets = subnet-a0d084d6,subnet-bec8ebda
// public_subnets = subnet-b6d783c0,subnet-fccfec98
// ssh_from_bastion_sg_id = sg-0e1d6469

