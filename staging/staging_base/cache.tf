resource "aws_elasticache_cluster" "redis-cache" {
  cluster_id = "redis-cache"
  engine = "redis"
  engine_version = "5.0.0"
  maintenance_window = "Wed:17:00-Wed:18:00"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.redis5.0"
  port = 6379
  subnet_group_name = "${aws_elasticache_subnet_group.redis-cache-subnet-group.name}"
  security_group_ids = ["${aws_security_group.redis-cache-security.id}"]
  snapshot_retention_limit = 0
}

resource "aws_elasticache_subnet_group" "redis-cache-subnet-group" {
  name = "redis-cache-subnet"
  subnet_ids = ["${aws_subnet.redis-cache-subnet.id}"]
}

resource "aws_subnet" "redis-cache-subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  count = 1
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "${var.stage}-${var.project}-redis-cache-subnet"
  }
}

resource "aws_security_group" "redis-cache-security" {
  name = "${var.stage}-${var.project}-redis-cache-security"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_groups = ["${aws_security_group.app-ec2-security.id}"]
  }

  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin-ec2-security.id}"]
  }

  tags = {
    Name = "${var.stage}-${var.project}-redis-cache-security"
  }
}
