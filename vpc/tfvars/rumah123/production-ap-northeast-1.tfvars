#Network Vars
common_name = "rumah123-production"
domain = "production.rumah123-singapore.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-rumah123-production-tokyo"

vpc_cidr = "10.91.16.0/20"
dopt = ["AmazonProvidedDNS","10.91.16.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.91.24.0/23","10.91.26.0/23"]
public_subnet_cidr_blocks = ["10.91.20.0/23","10.91.22.0/23"]
private_subnet_cidr_blocks = ["10.91.16.0/23","10.91.18.0/23"]

nat_subnet_supernet = "10.91.24.0/22"
public_subnet_supernet = "10.91.20.0/22"
private_subnet_supernet = "10.91.16.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"

//Outputs:

//aws_vpc_id = vpc-db4cdebf
//bastion_public_ip = 52.221.147.183
//nat_subnets = subnet-94ca89e2,subnet-0f306e6b
//private_subnets = subnet-95ca89e3,subnet-0d306e69
//public_subnets = subnet-97ca89e1,subnet-0e306e6a
//ssh_from_bastion_sg_id = sg-9aabc9fd