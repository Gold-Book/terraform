# managed subnets
resource "aws_subnet" "managed-ec2-subnet" {
  vpc_id = "vpc-0090a18b031d2c6e8"

  count = 1
  cidr_block = "10.0.40.0/24"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "${local.managed-prefix}-ec2-subnet"
  }
}

# routes
resource "aws_route_table" "managed-route-table" {
  vpc_id = "vpc-0090a18b031d2c6e8"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0fa988097b753d2a7"
  }

  tags {
    Name = "${local.managed-prefix}-route-table"
  }
}

resource "aws_route_table_association" "managed-route-association" {
  count = 1
  subnet_id = "${aws_subnet.managed-ec2-subnet.id}"
  route_table_id = "${aws_route_table.managed-route-table.id}"
}
