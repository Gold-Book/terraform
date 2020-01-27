resource "aws_security_group" "managed-ec2-security" {
  name = "${local.managed-prefix}-ec2-security"
  vpc_id = "vpc-0090a18b031d2c6e8"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["sg-08bfbc68df12df188"]
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
