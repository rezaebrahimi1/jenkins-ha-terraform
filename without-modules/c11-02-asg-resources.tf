resource "aws_placement_group" "jenkins" {
  name     = "jenkins"
  strategy = "cluster"
}
resource "aws_launch_template" "master" {
  name = "master"
  image_id = data.aws_ami.ami_raw.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.master_ami_type
  key_name = aws_key_pair.login.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.master.id]
  tag_specifications {
    resource_type = "instance"
    tags = merge({Name = "master-${local.environment}"}, local.common_tags)
  }
}
resource "aws_launch_template" "worker" {
  name = "worker"
  image_id = data.aws_ami.ami_raw.id
  instance_type = var.worker_ami_type
  instance_initiated_shutdown_behavior = "terminate"
  key_name = aws_key_pair.login.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.worker.id]
  tag_specifications {
    resource_type = "instance"
    tags = merge({Name = "worker-${local.environment}"}, local.common_tags)
  }
}
resource "aws_autoscaling_group" "master" {
  name                      = "master"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_template {
    id = aws_launch_template.master.id
    version = "$Latest"
  } 
  placement_group           = aws_placement_group.jenkins.id
  vpc_zone_identifier       = [element(aws_subnet.private.*.id,0)]

}
resource "aws_autoscaling_group" "worker" {
  capacity_rebalance  = true
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [element(aws_subnet.private.*.id,0)]
  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 25
      spot_allocation_strategy                 = "capacity-optimized"
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.worker.id
        version = "$Latest"
    }
  }
  }
}
resource "aws_autoscaling_policy" "master" {
  name                   = "master"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.master.name
}
resource "aws_autoscaling_policy" "worker" {
  name                   = "worker"
  adjustment_type        = "ChangeInCapacity"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.worker.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}
