# admin subnets
resource "aws_subnet" "admin-ec2-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = "${length(var.admin-ec2-subnets)}"
  cidr_block = "${element(var.admin-ec2-subnets, count.index)}"
  availability_zone = "${element(var.admin-az, count.index)}"

  tags {
    Name = "${local.admin-prefix}-ec2-subnet"
  }
}

# routes
resource "aws_route_table" "admin-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.app-network-gateway.id}"
  }

  tags {
    Name = "${local.admin-prefix}-route-table"
  }
}

resource "aws_route_table_association" "admin-route-association" {
  count = "${length(var.admin-ec2-subnets)}"
  subnet_id = "${element(aws_subnet.admin-ec2-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.admin-route-table.id}"
}
