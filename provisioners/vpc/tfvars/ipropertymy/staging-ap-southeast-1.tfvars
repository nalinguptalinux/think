#Network Vars
common_name = "ipropertymy-staging"
domain = "staging.ipropertymy-singapore.ipga.local"
region = "ap-southeast-1"
key_name = "awscloud-ipropertymy-staging-singapore"

vpc_cidr = "10.90.32.0/20"
dopt = ["AmazonProvidedDNS","10.90.32.2"]
zones = ["ap-southeast-1a","ap-southeast-1b"]
nat_subnet_cidr_blocks = ["10.90.40.0/23","10.90.42.0/23"]
public_subnet_cidr_blocks = ["10.90.36.0/23","10.90.38.0/23"]
private_subnet_cidr_blocks = ["10.90.32.0/23","10.90.34.0/23"]

nat_subnet_supernet = "10.90.40.0/22"
public_subnet_supernet = "10.90.36.0/22"
private_subnet_supernet = "10.90.32.0/22"

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

//State path: /root/IdeaProjects/infra-code/vpc/tfstate/ipropertymy/staging/iproperty-my-stage.tfstate

//Outputs:

//aws_vpc_id = vpc-5b6cf33f
//bastion_public_ip = 52.221.151.29
//nat_subnets = subnet-f599c291,subnet-e3fcb095
//private_subnets = subnet-719ac115,subnet-17feb261
//public_subnets = subnet-749bc010,subnet-98fcb0ee
//ssh_from_bastion_sg_id = sg-04acc463