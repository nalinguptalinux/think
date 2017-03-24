#Network Vars
common_name = "ipropertymy-development"
domain = "development.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-development-singapore"

vpc_cidr = "10.92.48.0/20"
dopt = ["AmazonProvidedDNS","10.92.48.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.92.56.0/23","10.92.58.0/23"]
public_subnet_cidr_blocks = ["10.92.52.0/23","10.92.54.0/23"]
private_subnet_cidr_blocks = ["10.92.48.0/23","10.92.50.0/23"]

nat_subnet_supernet = "10.92.56.0/22"
public_subnet_supernet = "10.92.52.0/22"
private_subnet_supernet = "10.92.48.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//
//aws_vpc_id = vpc-c9ef63ad
//bastion_public_ip = 52.221.97.29
//nat_subnets = subnet-36c6b440,subnet-9d9bd5f9
//private_subnets = subnet-37c6b441,subnet-939bd5f7
//public_subnets = subnet-49c6b43f,subnet-9c9bd5f8
//ssh_from_bastion_sg_id = sg-0834b66f
