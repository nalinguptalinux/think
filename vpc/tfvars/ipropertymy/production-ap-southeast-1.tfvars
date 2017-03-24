#Network Vars
common_name = "ipropertymy-production"
domain = "production.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-production-singapore"

vpc_cidr = "10.92.0.0/20"
dopt = ["AmazonProvidedDNS","10.92.0.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.92.8.0/23","10.92.10.0/23"]
public_subnet_cidr_blocks = ["10.92.4.0/23","10.92.6.0/23"]
private_subnet_cidr_blocks = ["10.92.0.0/23","10.92.2.0/23"]

nat_subnet_supernet = "10.92.8.0/22"
public_subnet_supernet = "10.92.4.0/22"
private_subnet_supernet = "10.92.0.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//Outputs:
//
//aws_vpc_id = vpc-1c70e178
//bastion_public_ip = 52.74.72.75
//nat_subnets = subnet-90b0f6e6,subnet-4ce6b428
//private_subnets = subnet-9eb0f6e8,subnet-43e6b427
//public_subnets = subnet-91b0f6e7,subnet-42e6b426
//ssh_from_bastion_sg_id = sg-6094f007
