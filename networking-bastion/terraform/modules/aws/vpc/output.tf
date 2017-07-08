output "aws_vpc_id" {
  value = "${aws_vpc.default.id}"
}
output "public_subnets" {
  value = "${join(",", aws_subnet.Public-Subnet.*.id)}"
}
output "private_subnets" {
  value = "${join(",", aws_subnet.Private-Subnet.*.id)}"
}
