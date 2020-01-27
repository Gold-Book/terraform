# managed subnets
resource "aws_subnet" "managed-ec2-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = "${length(var.managed-ec2-subnets)}"
  cidr_block = "${element(var.managed-ec2-subnets, count.index)}"
  availability_zone = "${element(var.managed-az, count.index)}"

  tags {
    Name = "${local.managed-prefix}-ec2-subnet"
  }
}

resource "aws_route_table_association" "managed-route-association" {
  count = "${length(var.managed-ec2-subnets)}"
  subnet_id = "${element(aws_subnet.managed-ec2-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.exampleapp-route-table.id}"
}
