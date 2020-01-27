resource "aws_security_group" "web-ec2-security" {
  name = "${local.web-prefix}-ec2-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name = "${local.web-prefix}-ec2-security"
  }
}
