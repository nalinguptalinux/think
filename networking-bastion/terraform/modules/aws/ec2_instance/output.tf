output "instance_profile_name" {
  value = "${aws_iam_instance_profile.s3-read.name}"
}
output "aws_instance_id" {
  value = "${aws_instance.web.id}"
}
output "aws_instance_ip" {
  value = "${aws_instance.web.public_ip}"
}
