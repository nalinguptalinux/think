#Network Vars
common_name = "squarefoot-staging"
domain = "staging.squarefoot-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-squarefoot-staging-singapore"

vpc_cidr = "10.39.32.0/20"
dopt = ["AmazonProvidedDNS","10.39.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.39.40.0/23","10.39.42.0/23"]
public_subnet_cidr_blocks = ["10.39.36.0/23","10.39.38.0/23"]
private_subnet_cidr_blocks = ["10.39.32.0/23","10.39.34.0/23"]

nat_subnet_supernet = "10.39.40.0/22"
public_subnet_supernet = "10.39.36.0/22"
private_subnet_supernet = "10.39.32.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//
//aws_vpc_id = vpc-74d35f10
//bastion_public_ip = 52.74.223.189
//nat_subnets = subnet-d7ddafa1,subnet-759fd111
//private_subnets = subnet-d6ddafa0,subnet-779fd113
//public_subnets = subnet-e9ddaf9f,subnet-769fd112
//ssh_from_bastion_sg_id = sg-042cae63
