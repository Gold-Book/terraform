resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "${var.stage}-${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "exampleapp-network-gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.stage}-exampleapp-network-gateway"
  }
}

resource "aws_route_table" "exampleapp-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.exampleapp-network-gateway.id}"
  }

  tags {
    Name = "${var.stage}-exampleapp-route-table"
  }
}
