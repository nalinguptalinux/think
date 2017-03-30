provider "aws" {
  region = "${var.region}"
  profile = "ipropertymydev"
  shared_credentials_file = "/root/.aws/credentials"
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

output "bastion_public_ip" {
  value = "${module.bastion.bastion_public_ip}"
}

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
