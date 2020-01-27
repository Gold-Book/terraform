resource "aws_instance" "managed-instance" {
  count = 1 # count 2 以上はeipが割り当てられないので不可
  ami = "${var.managed-ec2-ami}"
  instance_type = "${var.managed-ec2-type}"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.managed-instance-role.id}"
  security_groups = ["${aws_security_group.managed-ec2-security.id}"]
  subnet_id = "${element(aws_subnet.managed-ec2-subnet.*.id, count.index%length(var.managed-ec2-subnets))}"

  tags {
    Name = "${local.managed-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "managed-eip-assoc" {
  instance_id = "${aws_instance.managed-instance.id}"
  allocation_id = "${var.managed-eip}"
}

resource "aws_iam_instance_profile" "managed-instance-role" {
  name = "${local.managed-prefix}-ec2-instance-role"
  role = "${aws_iam_role.managed-iam-role.id}"
}
