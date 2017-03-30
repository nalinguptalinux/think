#Network Vars
common_name = "rumah123-production"
domain = "production.rumah123-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-rumah123-production-singapore"

vpc_cidr = "10.89.0.0/20"
dopt = ["AmazonProvidedDNS","10.89.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.89.8.0/23","10.89.10.0/23"]
public_subnet_cidr_blocks = ["10.89.4.0/23","10.89.6.0/23"]
private_subnet_cidr_blocks = ["10.89.0.0/23","10.89.2.0/23"]

nat_subnet_supernet = "10.89.8.0/22"
public_subnet_supernet = "10.89.4.0/22"
private_subnet_supernet = "10.89.0.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:

//aws_vpc_id = vpc-db4cdebf
//bastion_public_ip = 52.221.147.183
//nat_subnets = subnet-94ca89e2,subnet-0f306e6b
//private_subnets = subnet-95ca89e3,subnet-0d306e69
//public_subnets = subnet-97ca89e1,subnet-0e306e6a
//ssh_from_bastion_sg_id = sg-9aabc9fd