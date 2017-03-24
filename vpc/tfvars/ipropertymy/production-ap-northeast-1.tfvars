#Network Vars
common_name = "ipropertymy-production"
domain = "production.ipropertymy-singapore.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-ipropertymy-production-tokyo"

vpc_cidr = "10.92.16.0/20"
dopt = ["AmazonProvidedDNS","10.92.16.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.92.24.0/23","10.92.26.0/23"]
public_subnet_cidr_blocks = ["10.92.20.0/23","10.92.22.0/23"]
private_subnet_cidr_blocks = ["10.92.16.0/23","10.92.18.0/23"]

nat_subnet_supernet = "10.92.24.0/22"
public_subnet_supernet = "10.92.20.0/22"
private_subnet_supernet = "10.92.16.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"

//Outputs:
//
//aws_vpc_id = vpc-ea7cf18e
//bastion_public_ip = 13.113.68.100
//nat_subnets = subnet-53c98325,subnet-38b42260
//private_subnets = subnet-50c98326,subnet-07b4225f
//public_subnets = subnet-52c98324,subnet-39b42261
//ssh_from_bastion_sg_id = sg-43e9b024
