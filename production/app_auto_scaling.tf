resource "aws_autoscaling_group" "app-scaling-group" {
  name = "${local.app-prefix}-scaling-group"

  max_size = 2
  min_size = 2
  desired_capacity = 2

  health_check_grace_period = 300
  health_check_type = "EC2"

  vpc_zone_identifier = ["${aws_subnet.app-ec2-subnet.*.id}"]
  target_group_arns = ["${aws_alb_target_group.app-alb-target-group.id}"]
  launch_configuration = "${aws_launch_configuration.app-scaling-configuration.id}"

  force_delete = true

  tag = {
    key = "Name"
    value = "${local.app-prefix}-ec2-instance"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "app-scaling-configuration" {
  name = "${local.app-prefix}-scaling-configuration"

  image_id = "${var.app-ec2-ami}"
  instance_type = "${var.app-ec2-type}"
  enable_monitoring = false
  associate_public_ip_address = true

  key_name = "${local.ec2-ssh-key}"

  iam_instance_profile = "${aws_iam_instance_profile.app-instance-role.id}"
  security_groups = ["${aws_security_group.app-ec2-security.id}"]

  root_block_device {
    volume_size = 30
  }

  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "app-autoscaling-attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.app-scaling-group.id}"
  alb_target_group_arn   = "${aws_alb_target_group.app-alb-target-group.arn}"
}

resource "aws_iam_instance_profile" "app-instance-role" {
  name = "${local.app-prefix}-ec2-scaling-target-role"
  role = "${aws_iam_role.app-iam-role.id}"
}
