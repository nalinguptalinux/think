data "aws_iam_policy_document" "s3-read-iam-policy" {
  statement {
    sid = "1"
    actions = [
      "s3:List*",
      "s3:Get*",
    ]
    resources = [
      "*",
    ]
  }
}
resource "aws_iam_policy" "s3-read" {
  name = "s3-read-iam-policy"
  path = "/"
  policy = "${data.aws_iam_policy_document.s3-read-iam-policy.json}"
}
resource "aws_iam_role" "s3-read-role" {
  name = "s3-read-iam-role"
  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":"sts:AssumeRole",
         "Principal":{
            "Service":"ec2.amazonaws.com"
         },
         "Effect":"Allow",
         "Sid":""
      }
   ]
}
EOF
}
resource "aws_iam_role_policy" "s3-read-policy" {
  name = "s3-read-role-policy"
  role = "${aws_iam_role.s3-read-role.id}"
  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:Get*",
            "s3:List*"
         ],
         "Resource":"*"
      }
   ]
}
EOF
}
resource "aws_iam_instance_profile" "s3-read" {
  name = "s3-read-instance-porfile"
  role = "${aws_iam_role.s3-read-role.name}"
}
resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "bastion"
  }
  iam_instance_profile = "${aws_iam_instance_profile.s3-read.name}"
  subnet_id = "${element(split(",", var.public_subnet), 0)}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.bastion_ssh_sg.id}"]
  key_name = "${var.key_name}"
}

resource "aws_eip" "bastioneip" {
  instance = "${aws_instance.web.id}"
  vpc = true
}
resource "aws_security_group" "bastion_ssh_sg" {
  name = "Bastion-sg"
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
  vpc_id = "${var.aws_vpc}"
  tags {
    Name = "bastion-sg"
  }
}