resource "aws_instance" "managed-instance" {
  count = 1
  ami = "ami-0f9ecdf60efe3773b"
  instance_type = "t2.micro"
  key_name = "${local.ec2-ssh-key}"
  associate_public_ip_address = true
  iam_instance_profile = "stg-exampleapp-managed-role"
  security_groups = ["sg-0354ccaee98f455f5"]
  subnet_id = "${aws_subnet.managed-ec2-subnet.id}"

  tags {
    Name = "${local.managed-prefix}-ec2-instance"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.managed-instance.id}"
  allocation_id = "eipalloc-08da063e4329cb1fb"
}
