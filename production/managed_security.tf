resource "aws_security_group" "managed-ec2-security" {
  name = "${local.managed-prefix}-ec2-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.proxy-ec2-security.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.managed-prefix}-ec2-security"
  }
}
