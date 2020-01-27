resource "aws_instance" "proxy-instance" {
  count = 1
  ami = "ami-02e223ec85fff58a8"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  security_groups = ["sg-08bfbc68df12df188"]
  subnet_id = "subnet-00ea2caaa6a44723d"

  tags {
    Name = "${local.proxy-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.proxy-instance.id}"
  allocation_id = "eipalloc-097850884e60812d8"
}
