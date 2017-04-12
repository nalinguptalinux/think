#Network Vars
common_name = "ipropertymy-prod-tk"
domain = "prod.ipropertymy-tk.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-ipropertymy-prod-tk"

vpc_cidr = "10.90.16.0/20"
dopt = ["AmazonProvidedDNS","10.90.16.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.90.16.0/23","10.90.18.0/23"]
public_subnet_cidr_blocks = ["10.90.20.0/23","10.90.22.0/23"]
private_subnet_cidr_blocks = ["10.90.24.0/23","10.90.26.0/23"]

nat_subnet_supernet = "10.90.16.0/22"
public_subnet_supernet = "10.90.20.0/22"
private_subnet_supernet = "10.90.24.0/22"
profile_custom_profile = "ipropertymyprod-tk"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"

// Outputs:

// aws_vpc_id = vpc-5b2bb93f
// bastion_public_ip = 52.69.136.81
// nat_subnets = subnet-44103532,subnet-cc412694
// private_subnets = subnet-33173245,subnet-8e4c2bd6
// public_subnets = subnet-03123775,subnet-cd412695
// ssh_from_bastion_sg_id = sg-65131102
