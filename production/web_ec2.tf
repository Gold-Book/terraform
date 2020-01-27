resource "aws_instance" "web-instance" {
  count = 1
  ami = "${var.web-ec2-ami}"
  instance_type = "${var.web-ec2-type}"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.web-instance-role.id}"
  security_groups = ["${aws_security_group.web-ec2-security.id}"]
  subnet_id = "${aws_subnet.web-ec2-subnet.id}"

  tags {
    Name = "${local.web-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "web-eip-assoc" {
  instance_id = "${aws_instance.web-instance.id}"
  allocation_id = "${var.web-eip}"
}

resource "aws_iam_instance_profile" "web-instance-role" {
  name = "${local.web-prefix}-ec2-instance-role"
  role = "${aws_iam_role.web-iam-role.id}"
}
