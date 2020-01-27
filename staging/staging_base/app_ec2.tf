resource "aws_instance" "app-instance" {
  count = 2
  ami = "${var.app-ec2-ami}"
  instance_type = "${var.app-ec2-type}"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "ec2-instance-role"
  security_groups = ["${aws_security_group.app-ec2-security.id}"]
  subnet_id = "${element(aws_subnet.app-ec2-subnet.*.id, count.index%length(var.app-ec2-subnets))}"

  tags {
    Name = "${local.app-prefix}-ec2-instance"
  }
}
