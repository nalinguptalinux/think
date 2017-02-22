#Network Vars
common_name = "squarefoot-staging"
domain = "staging.squarefoot-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-squarefoot-staging-singapore"

vpc_cidr = "10.39.32.0/20"
dopt = ["AmazonProvidedDNS","10.39.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.39.40.0/23","10.39.42.0/24"]
public_subnet_cidr_blocks = ["10.39.36.0/23","10.39.38.0/28"]
private_subnet_cidr_blocks = ["10.39.32.0/23","10.39.34.0/23"]

nat_subnet_supernet = "10.39.40.0/22"
public_subnet_supernet = "10.39.36.0/22"
private_subnet_supernet = "10.39.32.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//aws_vpc_id = vpc-71901015
//bastion_public_ip = 52.221.87.241
//nat_subnets = subnet-36d2a040,subnet-848ec0e0
//private_subnets = subnet-60d2a016,subnet-d18ec0b5
//public_subnets = subnet-61d2a017,subnet-c28fc1a6
//ssh_from_bastion_sg_id = sg-5f179338
