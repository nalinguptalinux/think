#Network Vars
region = "ap-southeast-1"
vpc_cidr = "10.89.144.0/20"
common_name = "think-ofliving-prod-vpc"
domain_name = "think-ofliving.ipp.local"
dns_name = ["AmazonProvidedDNS","10.89.144.2"]
az = ["ap-southeast-1a" , "ap-southeast-1b"]
pub = ["10.89.144.0/23" , "10.89.146.0/23"]
priv = ["10.89.148.0/23" , "10.89.150.0/23"]

#Bastion Vars
instance_type = "t2.micro"
ami = "ami-fc5ae39f"
key_name = "awscloud-thinkofliving-Prod"


################
#aws_instance_id = i-0592305e57b5c2d67
#aws_instance_ip = 13.228.254.38
#aws_vpc_id = vpc-bc5119d8
#instance_profile_name = s3-read-instance-porfile
#private_subnets = subnet-f1736195,subnet-3814134e
#public_subnets = subnet-a87664cc,subnet-d31314a5

####################