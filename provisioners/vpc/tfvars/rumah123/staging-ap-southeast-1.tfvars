#Network Vars
common_name = "rumah123-staging"
domain = "staging.rumah123-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-rumah123-stag-singapore"

vpc_cidr = "10.89.32.0/20"
dopt = ["AmazonProvidedDNS","10.89.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.89.32.0/23","10.89.34.0/23"]
public_subnet_cidr_blocks = ["10.89.36.0/23","10.89.38.0/23"]
private_subnet_cidr_blocks = ["10.89.40.0/23","10.89.42.0/23"]

nat_subnet_supernet = "10.89.32.0/22"
public_subnet_supernet = "10.89.36.0/22"
private_subnet_supernet = "10.89.40.0/22"
profile_custom_profile = "rumah123staging"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"



// Outputs:

// aws_vpc_id = vpc-ea52348e
// bastion_public_ip = 52.221.177.53
// nat_subnets = subnet-0d8eac69,subnet-d9eeb9af
// private_subnets = subnet-5488aa30,subnet-ddedbaab
// public_subnets = subnet-9388aaf7,subnet-24edba52
// ssh_from_bastion_sg_id = sg-a96d16ce


