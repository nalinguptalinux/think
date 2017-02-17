provider "aws" {
  region = "${var.region}"
}
module "network" {
  source = "./modules/aws/network"
  common_name = "${var.common_name}"

  region = "${var.region}"
  domain = "${var.domain}"
  key_name = "${var.key_name}"

  vpc_cidr = "${var.vpc_cidr}"
  dopt = "${var.dopt}"

  zones = "${var.zones}"
  nat_subnet_cidr_blocks = "${var.nat_subnet_cidr_blocks}"
  public_subnet_cidr_blocks = "${var.public_subnet_cidr_blocks}"
  private_subnet_cidr_blocks = "${var.private_subnet_cidr_blocks}"

  nat_subnet_supernet = "${var.nat_subnet_supernet}"
  public_subnet_supernet = "${var.public_subnet_supernet}"
  private_subnet_supernet = "${var.private_subnet_supernet}"
}

module "bastion" {
  source = "./modules/aws/bastion"
  region = "${var.region}"
  domain = "${var.domain}"
  key_name = "${var.key_name}"
  aws_vpc_id =  "${module.network.vpc_id}"
  nat_subnets = "${module.network.nat_subnets}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
}

//module "webappasg" {
//  source = "./modules/aws/webappasg"
//  region = "${var.region}"
//  aws_vpc_id =  "${module.network.vpc_id}"
//  nat_subnet_cidr_blocks = "${var.nat_subnet_cidr_blocks}"
//  public_subnet_cidr_blocks = "${var.public_subnet_cidr_blocks}"
//  ami = "ami-08111162"
//  instance_type = "t2.nano"
//  key_name = "${var.key_name}"
//  public_subnets = "${module.network.public_subnets}"
//  asg_min = "1"
//  asg_max = "2"
//  user_data_file = "./modules/aws/webappasg/userdata.sh"
//}
//
//module "public_subnet_instance" {
//  source = "./modules/aws/instances"
//  region = "${var.region}"
//  ami = "ami-08111162"
//  instance_type = "t2.nano"
//  key_name = "${var.key_name}"
//  public_subnet_id = "${element(split(",",module.network.public_subnets),"1")}"
//  ssh_from_bastion_sg_id = "${module.bastion.ssh_from_bastion_sg_id}"
//}


output "bastion_public_ip" {
  value = "${module.bastion.bastion_public_ip}"
}
//output "asg_elb_dns_name" {
//  value = "${module.webappasg.asg_elb_dns_name}"
//}
output "aws_vpc_id" {
  value = "${module.network.aws_vpc_id}"
}
output "public_subnets" {
  value = "${module.network.public_subnets}"
}
output "private_subnets" {
  value = "${module.network.private_subnets}"
}
output "nat_subnets" {
  value = "${module.network.nat_subnets}"
}
output "ssh_from_bastion_sg_id" {
  value = "${module.bastion.ssh_from_bastion_sg_id}"
}

//resource "terraform_remote_state" "remote_state" {
//  backend = "s3"
//  config {
//    bucket = "mybucketname"
//    key = "nam_of_key_file"
//  }
//}
//
//module "app" {
//  source = "modules/blue-green"
//  name = "app"
//  vpc_id = "${terraform_remote_state.remote_state.output.vpc_id}"
//  subnets = "${terraform_remote_state.remote_state.output.app_subnets}"
//}

