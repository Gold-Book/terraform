resource "aws_instance" "proxy-instance" {
  count = 1 # count 2 以上はeipが割り当てられないので不可
  ami = "${var.proxy-ec2-ami}"
  instance_type = "${var.proxy-ec2-type}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.proxy-instance-role.id}"
  security_groups = ["${aws_security_group.proxy-ec2-security.id}"]
  subnet_id = "${element(aws_subnet.proxy-ec2-subnet.*.id, count.index%length(var.proxy-ec2-subnets))}"

  tags {
    Name = "${local.proxy-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "proxy-eip-assoc" {
  instance_id = "${aws_instance.proxy-instance.id}"
  allocation_id = "${var.proxy-eip}"
}

resource "aws_iam_instance_profile" "proxy-instance-role" {
  name = "${local.proxy-prefix}-ec2-instance-role"
  role = "${aws_iam_role.proxy-iam-role.id}"
}
