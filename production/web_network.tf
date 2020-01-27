# web subnets
resource "aws_subnet" "web-ec2-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = 1
  cidr_block = "10.0.30.0/24"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "${local.web-prefix}-ec2-subnet"
  }
}

resource "aws_route_table_association" "web-route-association" {
  count = 1
  subnet_id = "${aws_subnet.web-ec2-subnet.id}"
  route_table_id = "${aws_route_table.exampleapp-route-table.id}"
}
