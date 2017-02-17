#Network Vars
common_name = "squarefoot-staging"
domain = "staging.squarefoot-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-squarefoot-staging-singapore"

vpc_cidr = "10.39.32.0/20"
dopt = ["AmazonProvidedDNS","10.39.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.39.38.0/24","10.39.39.0/24"]
public_subnet_cidr_blocks = ["10.39.36.0/24","10.39.37.0/24"]
private_subnet_cidr_blocks = ["10.39.34.0/24","10.39.35.0/24"]

nat_subnet_supernet = "10.39.38.0/23"
public_subnet_supernet = "10.39.36.0/23"
private_subnet_supernet = "10.39.34.0/23"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//aws_vpc_id = vpc-71901015
//bastion_public_ip = 52.221.87.241
//nat_subnets = subnet-d52554a3,subnet-8890d2ec
//private_subnets = subnet-d72554a1,subnet-8a90d2ee
//public_subnets = subnet-d42554a2,subnet-8990d2ed
//ssh_from_bastion_sg_id = sg-5f179338
