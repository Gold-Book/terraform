resource "aws_security_group" "app-lb-security" {
  name = "${local.app-prefix}-lb-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${local.app-prefix}-lb-security"
  }
}

resource "aws_security_group" "app-ec2-security" {
  name = "${local.app-prefix}-ec2-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.app-lb-security.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.app-prefix}-ec2-security"
  }
}
