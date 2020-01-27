# admin alb
resource "aws_alb" "admin-alb" {
  name = "${local.admin-prefix}-alb"
  load_balancer_type = "application"

  internal = false

  subnets = ["${aws_subnet.admin-ec2-subnet.*.id}"]
  security_groups = ["${aws_security_group.admin-lb-security.id}"]

  access_logs {
    bucket = "${local.private-logs-bucket}"
    prefix = "admin/alb"
    enabled = true
  }

  tags {
    Name = "${local.admin-prefix}-alb"
  }
}

resource "aws_alb_listener" "admin-alb-listener" {
  load_balancer_arn = "${aws_alb.admin-alb.arn}"

  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "${var.acm-tokyo-arn}"

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.admin-alb-target-group.arn}"
  }
}

resource "aws_alb_target_group" "admin-alb-target-group" {
  name = "${local.admin-prefix}-alb-target-group"

  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.vpc.id}"

  health_check {
    timeout = 5
    interval = 30
    healthy_threshold = 10
    port = 80
    matcher = 200
    protocol = "HTTP"
    path = "/health_check"
  }

  tags {
    Name = "${local.admin-prefix}-alb-target-group"
  }
}
