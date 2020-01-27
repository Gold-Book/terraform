resource "aws_security_group" "admin-lb-security" {
  name = "${local.admin-prefix}-lb-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["39.110.216.50/32"]
    description = "JF office"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["39.110.235.25/32"]
    description = "adg office"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.admin-prefix}-lb-security"
  }
}

resource "aws_security_group" "admin-ec2-security" {
  name = "${local.admin-prefix}-ec2-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin-lb-security.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.admin-prefix}-ec2-security"
  }
}
