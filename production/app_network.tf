# app subnets
resource "aws_subnet" "app-ec2-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = "${length(var.app-ec2-subnets)}"
  cidr_block = "${element(var.app-ec2-subnets, count.index)}"
  availability_zone = "${element(var.app-az, count.index)}"

  tags {
    Name = "${local.app-prefix}-ec2-subnet"
  }
}

resource "aws_route_table_association" "app-route-association" {
  count = "${length(var.app-ec2-subnets)}"
  subnet_id = "${element(aws_subnet.app-ec2-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.exampleapp-route-table.id}"
}
