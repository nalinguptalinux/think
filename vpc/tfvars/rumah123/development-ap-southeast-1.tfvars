#Network Vars
common_name = "rumah123-development"
domain = "development.rumah123-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-rumah123-development-singapore"

vpc_cidr = "10.89.48.0/20"
dopt = ["AmazonProvidedDNS","10.89.48.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.89.56.0/23","10.89.58.0/23"]
public_subnet_cidr_blocks = ["10.89.52.0/23","10.89.54.0/23"]
private_subnet_cidr_blocks = ["10.89.48.0/23","10.89.50.0/23"]

nat_subnet_supernet = "10.89.56.0/22"
public_subnet_supernet = "10.89.52.0/22"
private_subnet_supernet = "10.89.48.0/22"

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-dc9339bf"

//module.network.aws_route_table_association.private-subnet.0: Creation complete
//module.network.aws_route_table_association.private-subnet.1: Creation complete

//Apply complete! Resources: 32 added, 0 changed, 0 destroyed.

//The state of your infrastructure has been saved to the path
//below. This state is required to modify and destroy your
//infrastructure, so keep it safe. To inspect the complete state
//use the `terraform show` command.

//State path: tfstate/rumah123/development/rumah123-dev.tfstate

//Outputs:

//aws_vpc_id = vpc-e19d0285
//bastion_public_ip = 52.221.139.174
//nat_subnets = subnet-b4733fc2,subnet-3d114a59
//private_subnets = subnet-31733f47,subnet-df1c47bb
//public_subnets = subnet-30733f46,subnet-4913482d
//ssh_from_bastion_sg_id = sg-5483ea33
