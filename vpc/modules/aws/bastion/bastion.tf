provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "bastion_ssh_sg" {
  name = "bastion-sg"
  description = "Allow SSH to Bastion host from approved ranges"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = -1
    to_port = -1
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${var.aws_vpc_id}"
  tags {
    Name = "bastion-sg"
  }
}

data "template_file" "user_data" {
  template = "${file("user_data.tpl")}"
  vars {
    record_name = "bastion"
  }
}

//data "aws_iam_policy_document" "s3-read" {
//  statement {
//    sid = "1"
//    actions = [
//      "s3:List*",
//      "s3:Get*",
//    ]
//    resources = [
//      "*",
//    ]
//  }
//}
//
//resource "aws_iam_policy" "s3-read" {
//  name = "s3-read"
//  path = "/"
//  policy = "${data.aws_iam_policy_document.s3-read.json}"
//}

//resource "aws_iam_role" "s3-read" {
//  name = "s3-read"
//  assume_role_policy = <<EOF
//{
//   "Version":"2012-10-17",
//   "Statement":[
//      {
//         "Action":"sts:AssumeRole",
//         "Principal":{
//            "Service":"ec2.amazonaws.com"
//         },
//         "Effect":"Allow",
//         "Sid":""
//      }
//   ]
//}
//EOF
//}
//
//resource "aws_iam_role_policy" "s3-read" {
//  name = "s3-read"
//  role = "${aws_iam_role.s3-read.id}"
//  policy = <<EOF
//{
//   "Version":"2012-10-17",
//   "Statement":[
//      {
//         "Effect":"Allow",
//         "Action":[
//            "s3:Get*",
//            "s3:List*"
//         ],
//         "Resource":"*"
//      }
//   ]
//}
//EOF
//}

//resource "aws_iam_instance_profile" "s3-read" {
//  name = "s3-read"
//  roles = ["${aws_iam_role.s3-read.name}"]
//}

resource "aws_instance" "bastion" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "bastion"
  }
  subnet_id = "${element(split(",", var.nat_subnets), 0)}"
  user_data = "${data.template_file.user_data.rendered}"
  iam_instance_profile = "s3-read"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.bastion_ssh_sg.id}"]
  key_name = "${var.key_name}"
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true
}

resource "aws_security_group" "ssh_from_bastion_sg" {
  name = "ssh-from-bastion-sg"
  description = "Allow SSH from Bastion host(s)"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [
      "${aws_security_group.bastion_ssh_sg.id}",
    ]
    self = true
  }
  ingress {
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = -1
    to_port = -1
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${var.aws_vpc_id}"
  tags {
    Name = "ssh-from-bastion-sg"
  }
}

resource "aws_route53_zone" "internal" {
  name = "${var.domain}."
  vpc_id = "${var.aws_vpc_id}"
  tags {
    Purpose = "Internal DNS Mapping"
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name = "bastion"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.bastion.private_ip}"]
}


output "bastion_public_ip" {
  value = "${aws_eip.bastion.public_ip}"
}
output "ssh_from_bastion_sg_id" {
  value = "${aws_security_group.ssh_from_bastion_sg.id}"
}


