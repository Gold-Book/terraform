# proxy subnets
resource "aws_subnet" "proxy-ec2-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = "${length(var.proxy-ec2-subnets)}"
  cidr_block = "${element(var.proxy-ec2-subnets, count.index)}"
  availability_zone = "${element(var.proxy-az, count.index)}"

  tags {
    Name = "${local.proxy-prefix}-ec2-subnet"
  }
}

resource "aws_route_table_association" "proxy-route-association" {
  count = "${length(var.proxy-ec2-subnets)}"
  subnet_id = "${element(aws_subnet.proxy-ec2-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.exampleapp-route-table.id}"
}
