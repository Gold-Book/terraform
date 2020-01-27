resource "aws_instance" "admin-instance" {
  count = 1
  ami = "${var.admin-ec2-ami}"
  instance_type = "${var.admin-ec2-type}"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "ec2-instance-role"
  security_groups = ["${aws_security_group.admin-ec2-security.id}"]
  subnet_id = "${element(aws_subnet.admin-ec2-subnet.*.id, count.index%length(var.admin-ec2-subnets))}"

  tags {
    Name = "${local.admin-prefix}-ec2-instance"
  }
}
