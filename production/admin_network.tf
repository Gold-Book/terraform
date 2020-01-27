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

resource "aws_route_table_association" "admin-route-association" {
  count = "${length(var.admin-ec2-subnets)}"
  subnet_id = "${element(aws_subnet.admin-ec2-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.exampleapp-route-table.id}"
}
