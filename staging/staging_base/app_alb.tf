# app alb
resource "aws_alb" "app-alb" {
  name = "${local.app-prefix}-alb"

  internal = false
  load_balancer_type = "application"

  subnets = ["${aws_subnet.app-ec2-subnet.*.id}"]
  security_groups = ["${aws_security_group.app-lb-security.id}"]

  access_logs {
    bucket = "${local.private-logs-bucket}"
    prefix = "app/alb"
    enabled = true
  }

  tags {
    Name = "${local.app-prefix}-alb"
  }
}

resource "aws_alb_listener" "app-alb-listener" {
  load_balancer_arn = "${aws_alb.app-alb.arn}"

  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.app-alb-target-group.arn}"
  }
}

resource "aws_alb_target_group" "app-alb-target-group" {
  name = "${local.app-prefix}-alb-target-group"

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
    Name = "${local.app-prefix}-alb-target-group"
  }
}

resource "aws_alb_target_group_attachment" "app-alb-target-group-attachment" {
  count = "${aws_instance.app-instance.count}"
  target_group_arn = "${aws_alb_target_group.app-alb-target-group.arn}"
  target_id = "${element(aws_instance.app-instance.*.id, count.index)}"
  port = 80
}
