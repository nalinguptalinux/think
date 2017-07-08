provider "aws" {
  region = "${var.region}"
}
#provider "aws" {
#  region                  = "${var.region}"
#  shared_credentials_file = "/home/nalin/.aws/credentials"
#  profile                 = "test-account"
#}
module "vpc" {                                                       ###################  Module calling with variable
  source = "modules/aws/vpc"
  region = "${var.region}"
  vpc_cidr = "${var.vpc_cidr}"
  common_name = "${var.common_name}"
  domain_name = "${var.domain_name}"
  dns_name = "${var.dns_name}"
  pub = "${var.pub}"
  priv = "${var.priv}"
  az = "${var.az}"
  key_name = "${var.key_name}"
}
module "ec2_instance" {                                                ###################  Module calling ec2-instance
  source = "modules/aws/ec2_instance"
  common_name = "${var.common_name}"
  ami = "${var.ami}"
  public_subnet = "${module.vpc.public_subnets}"
  vpc_cidr = "${module.vpc.aws_vpc_id}"
  instance_type = "${var.instance_type}"
  domain_name = "${var.domain_name}"
  key_name = "${var.key_name}"
  aws_vpc = "${module.vpc.aws_vpc_id}"
}

output "aws_vpc_id" {                                        #####################   Storing output
  value = "${module.vpc.aws_vpc_id}"
}
output "public_subnets" {
  value = "${module.vpc.public_subnets}"                    ####################    Public Subnet
}
output "private_subnets" {                                 ####################     Private Subnet
  value = "${module.vpc.private_subnets}"
}
output "instance_profile_name" {
  value = "${module.ec2_instance.instance_profile_name}"
}
output "aws_instance_id" {
  value = "${module.ec2_instance.aws_instance_id}"
}
output "aws_instance_ip" {
  value = "${module.ec2_instance.aws_instance_ip}"
}