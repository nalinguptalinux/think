resource "aws_vpc_dhcp_options" "dns_resolver" {               ############   DHCP
  domain_name          = "${var.domain_name}"
  domain_name_servers = "${var.dns_name}"
  tags {
    Name = "${var.common_name}-dhcp-option"
  }
}
resource "aws_vpc" "default" {                                    #########   VPC
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags {
    Name = "${var.common_name}-terraform"
  }
}
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.default.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
}
resource "aws_subnet" "Public-Subnet" {
  vpc_id     = "${aws_vpc.default.id}"
  count = "${length(var.pub)}"
  cidr_block = "${element(var.pub, count.index)}"
  map_public_ip_on_launch = true
  availability_zone = "${element(var.az, count.index)}"
  tags {
    Name = "public_${element(var.az, count.index)}-subnet"
  }
}
resource "aws_subnet" "Private-Subnet" {
  vpc_id     = "${aws_vpc.default.id}"
  count = "${length(var.priv)}"
  cidr_block = "${element(var.priv, count.index)}"
  map_public_ip_on_launch = true
  availability_zone = "${element(var.az, count.index)}"
  tags {
    Name = "private_${element(var.az, count.index)}-subnet"
  }
}
########  S3 ENDPOINT
resource "aws_vpc_endpoint" "private-s3" {
  vpc_id     = "${aws_vpc.default.id}"
  service_name = "com.amazonaws.ap-southeast-1.s3"
  #route_table_ids = ["${aws_route_table.Private-route-table.id}"]
  count = "${length(var.priv)}"
  route_table_ids = ["${element(aws_route_table.Private-route-table.*.id, count.index)}"]
  policy = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}
########
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "Internet-gateway-${var.common_name}"
  }
}
resource "aws_eip" "nat" {                                                # Elastic IP for NAT Gateway
  count = "${length(var.pub)}"
  vpc = true
  depends_on = [
    "aws_internet_gateway.gw"]
}
resource "aws_nat_gateway" "default" {                                       # NAT Gateway for each zone
  count = "${length(var.pub)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.Public-Subnet.*.id, count.index)}"
  depends_on = [
    "aws_internet_gateway.gw"]
}
resource "aws_route_table" "Public-route-table" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags {
    Name = "Public-route-table"
  }
}
resource "aws_route_table_association" "pub_route_associate" {
  count = "${length(var.pub)}"
  subnet_id = "${element(aws_subnet.Public-Subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.Public-route-table.id}"
}
resource "aws_route_table" "Private-route-table" {
  vpc_id = "${aws_vpc.default.id}"
  count = "${length(var.priv)}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = "${element(aws_nat_gateway.default.*.id, count.index)}"
  }
  tags {
    Name = "private_${element(var.az, count.index)}"
  }
}
resource "aws_route_table_association" "priv_route_associate" {
  count = "${length(var.priv)}"
  subnet_id = "${element(aws_subnet.Private-Subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.Private-route-table.*.id, count.index)}"
}
resource "aws_network_acl" "public_acl" {                             ###########  Public Subnet NACL
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.Public-Subnet.*.id}"]

  #Outbound: All traffic
  egress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  #Inbound: All VPC, HTTP/S, ICMP, Ephermal
  ingress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "tcp"
    rule_no = 2
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
  }
  ingress {
    protocol = "tcp"
    rule_no = 3
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
  }
  ingress {
    protocol = "tcp"
    rule_no = 4
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }
  ingress {
    protocol = "udp"
    rule_no = 5
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }
  ingress {
    protocol = "udp"
    rule_no = 6
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 123
    to_port = 123
  }
  ingress {
    protocol = "icmp"
    rule_no = 7
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
  }
  ingress {
    protocol = "tcp"
    rule_no = 8
    action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = 22
    to_port = 22
  }
  ingress {
    protocol = "tcp"
    rule_no = 9
    action = "allow"
    cidr_block = "121.122.7.17/32"
    from_port = 22
    to_port = 22
  }
  tags {
    Name = "Public_nacl"
  }
}