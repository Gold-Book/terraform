resource "aws_instance" "web-instance" {
  count = 1
  ami = "ami-0f27edf319b4c6541"
  instance_type = "t2.micro"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "stg-exampleapp-web-role"
  security_groups = ["${aws_security_group.web-ec2-security.id}"]
  subnet_id = "${aws_subnet.web-ec2-subnet.id}"

  tags {
    Name = "${local.web-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.web-instance.id}"
  allocation_id = "eipalloc-0eec8e37f13ad7517"
}
