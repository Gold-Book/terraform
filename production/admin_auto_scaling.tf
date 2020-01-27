resource "aws_autoscaling_group" "admin-scaling-group" {
  name = "${local.admin-prefix}-scaling-group"

  max_size = 1
  min_size = 1
  desired_capacity = 1

  health_check_grace_period = 300
  health_check_type = "EC2"

  vpc_zone_identifier = ["${aws_subnet.admin-ec2-subnet.*.id}"]
  target_group_arns = ["${aws_alb_target_group.admin-alb-target-group.id}"]
  launch_configuration = "${aws_launch_configuration.admin-scaling-configuration.id}"

  force_delete = true

  tag = {
    key = "Name"
    value = "${local.admin-prefix}-ec2-instance"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "admin-scaling-configuration" {
  name = "${local.admin-prefix}-scaling-configuration"

  image_id = "${var.admin-ec2-ami}"
  instance_type = "${var.admin-ec2-type}"
  enable_monitoring = false
  associate_public_ip_address = true

  key_name = "${local.ec2-ssh-key}"

  iam_instance_profile = "${aws_iam_instance_profile.admin-instance-role.id}"
  security_groups = ["${aws_security_group.admin-ec2-security.id}"]

  root_block_device {
    volume_size = 30
  }

  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "admin-autoscaling-attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.admin-scaling-group.id}"
  alb_target_group_arn   = "${aws_alb_target_group.admin-alb-target-group.arn}"
}

resource "aws_iam_instance_profile" "admin-instance-role" {
  name = "${local.admin-prefix}-ec2-scaling-target-role"
  role = "${aws_iam_role.admin-iam-role.id}"
}
