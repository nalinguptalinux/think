provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc_dhcp_options" "default" {
  domain_name = "${var.domain}"
  domain_name_servers = "${var.dopt}"
  tags {
    Name = "${var.domain}"
  }
}


#Default VPC for all resources
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "${var.common_name}"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id = "${aws_vpc.default.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
}

# Internet Gateway for VPC
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "${var.common_name}"
  }
}

#Public Subnet in Each Zone
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.default.id}"
  count = "${length(var.public_subnet_cidr_blocks)}"
  cidr_block = "${element(var.public_subnet_cidr_blocks, count.index)}"
  availability_zone = "${element(var.zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "public_${element(var.zones, count.index)}"
  }
}

#Private Subnet in Each Zone
resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.default.id}"
  count = "${length(var.private_subnet_cidr_blocks)}"
  cidr_block = "${element(var.private_subnet_cidr_blocks, count.index)}"
  availability_zone = "${element(var.zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "private_${element(var.zones, count.index)}"
  }
}

#Nat Subnet in Each Zone
resource "aws_subnet" "nat" {
  vpc_id = "${aws_vpc.default.id}"
  count = "${length(var.nat_subnet_cidr_blocks)}"
  cidr_block = "${element(var.nat_subnet_cidr_blocks, count.index)}"
  availability_zone = "${element(var.zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "nat_${element(var.zones, count.index)}"
  }
}

# Cross Zone ACL for Public Subnet
resource "aws_network_acl" "public" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.public.*.id}"]

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
    protocol = "icmp"
    rule_no = 6
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
  }

  tags {
    Name = "public_acl_all_subnets"
  }
}

# Cross Zone ACL for Private Subnet
resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.private.*.id}"]

  # Outbound: All VPC
  egress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  #Inbound: All from NAT, within Private. HTTP/s Ephermal from Public
  ingress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "${var.nat_subnet_supernet}"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "-1"
    rule_no = 2
    action = "allow"
    cidr_block = "${var.private_subnet_supernet}"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "tcp"
    rule_no = 3
    action = "allow"
    cidr_block = "${var.public_subnet_supernet}"
    from_port = 80
    to_port = 80
  }
  ingress {
    protocol = "tcp"
    rule_no = 4
    action = "allow"
    cidr_block = "${var.public_subnet_supernet}"
    from_port = 443
    to_port = 443
  }
  ingress {
    protocol = "tcp"
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
    from_port = 1024
    to_port = 65535
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

  tags {
    Name = "private_acl_all_subnets"
  }
}

# Cross Zone ACL for NAT Subnet
resource "aws_network_acl" "nat" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.nat.*.id}"]
  #Outbound Traffic, Allow All

  egress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  #Inbound: All NAT, Ephermal, Ping, SSH
  ingress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "${var.nat_subnet_supernet}"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "-1"
    rule_no = 2
    action = "allow"
    cidr_block = "${var.private_subnet_supernet}"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "tcp"
    rule_no = 3
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }
  ingress {
    protocol = "udp"
    rule_no = 4
    action = "allow"
    cidr_block =  "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }
  ingress {
    protocol = "icmp"
    rule_no = 5
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
  }
  ingress {
    protocol = "tcp"
    rule_no = 6
    action = "allow"
    cidr_block = "202.66.38.130/32"
    from_port = 22
    to_port = 22
  }
  ingress {
    protocol = "tcp"
    rule_no = 7
    action = "allow"
    cidr_block = "121.122.7.17/32"
    from_port = 22
    to_port = 22
  }
  ingress {
    protocol = "tcp"
    rule_no = 8
    action = "allow"
    cidr_block = "121.122.7.177/32"
    from_port = 22
    to_port = 22
  }

  tags {
    Name = "nat_acl_all_subnets"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count = "${length(var.nat_subnet_cidr_blocks)}"
  vpc = true
  depends_on = [
    "aws_internet_gateway.default"]
}

# NAT Gateway for each zone
resource "aws_nat_gateway" "default" {
  count = "${length(var.nat_subnet_cidr_blocks)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.nat.*.id, count.index)}"
  depends_on = [
    "aws_internet_gateway.default"]
}

# Route for Internet Traffic
resource "aws_route_table" "internet" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "internet_gateway_route"
  }
}

resource "aws_route_table_association" "public-subnet" {
  count = "${length(var.public_subnet_cidr_blocks)}"
  subnet_id = "${element(aws_subnet.nat.*.id, count.index)}"
  route_table_id = "${aws_route_table.internet.id}"
}
resource "aws_route_table_association" "nat-subnet" {
  count = "${length(var.nat_subnet_cidr_blocks)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.internet.id}"
}

resource "aws_route_table" "nat-gateway" {
  vpc_id = "${aws_vpc.default.id}"
  count = "${length(var.nat_subnet_cidr_blocks)}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = "${element(aws_nat_gateway.default.*.id, count.index)}"
  }

  tags {
    Name = "nat_${element(var.zones, count.index)}"
  }
}

resource "aws_route_table_association" "private-subnet" {
  count = "${length(var.private_subnet_cidr_blocks)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.nat-gateway.*.id, count.index)}"
}

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "aws_vpc_id" {
  value = "${aws_vpc.default.id}"
}
output "public_subnets" {
  value = "${join(",", aws_subnet.public.*.id)}"
}
output "private_subnets" {
  value = "${join(",", aws_subnet.private.*.id)}"
}
output "nat_subnets" {
  value = "${join(",", aws_subnet.nat.*.id)}"
}



