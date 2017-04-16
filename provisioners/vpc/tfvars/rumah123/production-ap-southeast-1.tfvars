#Network Vars
common_name = "rumah123-prod-sg"
domain = "prod.rumah123-sg.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-rumah123-production-singapore"

vpc_cidr = "10.89.0.0/20"
dopt = ["AmazonProvidedDNS","10.89.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.89.0.0/23","10.89.2.0/23"]
public_subnet_cidr_blocks = ["10.89.4.0/23","10.89.6.0/23"]
private_subnet_cidr_blocks = ["10.89.8.0/23","10.89.10.0/23"]

nat_subnet_supernet = "10.89.0.0/22"
public_subnet_supernet = "10.89.4.0/22"
private_subnet_supernet = "10.89.8.0/22"
profile_custom_profile = "rumah123prod-sg"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

// Outputs:

// aws_vpc_id = vpc-54c2a530
// bastion_public_ip = 13.228.19.118
// nat_subnets = subnet-42371526,subnet-f07e2986
// private_subnets = subnet-6e36140a,subnet-967e29e0
// public_subnets = subnet-863715e2,subnet-e87d2a9e
// ssh_from_bastion_sg_id = sg-055c2462

