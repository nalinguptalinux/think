#Network Vars
common_name = "ipropertysg-prod-tk"
domain = "prod.ipropertysg-tokyo.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-ipropertysg-prod-tokyo"

vpc_cidr = "10.90.176.0/20"
dopt = ["AmazonProvidedDNS","10.90.176.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.90.176.0/23","10.90.178.0/23"]
public_subnet_cidr_blocks = ["10.90.180.0/23","10.90.182.0/23"]
private_subnet_cidr_blocks = ["10.90.184.0/23","10.90.186.0/23"]

nat_subnet_supernet = "10.90.176.0/22"
public_subnet_supernet = "10.90.180.0/22"
private_subnet_supernet = "10.90.184.0/22"
profile_custom_profile = "ipropertysgprod-tk"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"


// Outputs:

// aws_vpc_id = vpc-8dba28e9
// bastion_public_ip = 52.199.194.43
// nat_subnets = subnet-ebce949d,subnet-baf094e2
// private_subnets = subnet-b4d78dc2,subnet-11fc9849
// public_subnets = subnet-9dca90eb,subnet-23f0947b
// // ssh_from_bastion_sg_id = sg-cf5350a8

