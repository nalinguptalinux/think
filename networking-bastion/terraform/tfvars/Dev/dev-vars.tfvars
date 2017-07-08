#Network Vars
region = "ap-southeast-1"
vpc_cidr = "10.89.128.0/20"
common_name = "think-ofliving-dev-vpc"
domain_name = "think-ofliving.ipp.local"
dns_name = ["AmazonProvidedDNS","10.89.128.2"]
az = ["ap-southeast-1a" , "ap-southeast-1b"]
pub = ["10.89.128.0/23" , "10.89.130.0/23"]
priv = ["10.89.132.0/23" , "10.89.134.0/23"]

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-fc5ae39f"
key_name = "awscloud-thinkofliving-development"


################
#aws_instance_id = i-05e7382c4f0b6793e
#aws_instance_ip = 13.228.84.236
#aws_vpc_id = vpc-15d49571
#instance_profile_name = s3-read-instance-porfile
#private_subnets = subnet-5e727a3a,subnet-47655831
#public_subnets = subnet-30737b54,subnet-cb6b56bd

####################