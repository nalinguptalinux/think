#Network Vars
common_name = "rumah123-prod-tk"
domain = "prod.rumah123-tk.ipga.local"
region = "ap-northeast-1"
key_name = "awscloud-rumah123-prod-tk"

vpc_cidr = "10.89.16.0/20"
dopt = ["AmazonProvidedDNS","10.89.16.2"]
zones = ["ap-northeast-1a","ap-northeast-1c"]
nat_subnet_cidr_blocks = ["10.89.16.0/23","10.89.18.0/23"]
public_subnet_cidr_blocks = ["10.89.20.0/23","10.89.22.0/23"]
private_subnet_cidr_blocks = ["10.89.24.0/23","10.89.26.0/23"]

nat_subnet_supernet = "10.89.16.0/22"
public_subnet_supernet = "10.89.20.0/22"
private_subnet_supernet = "10.89.24.0/22"
profile_custom_profile = "rumah123prod-tk"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-56d4ad31"

// Outputs:

// aws_vpc_id = vpc-d6d74ab2
// bastion_public_ip = 13.112.69.178
// nat_subnets = subnet-881a3ffe,subnet-00533458
// private_subnets = subnet-fb193c8d,subnet-01533459
// public_subnets = subnet-09e4c17f,subnet-0c503754
// ssh_from_bastion_sg_id = sg-aa2a28cd

