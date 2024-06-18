resource "aws_cloudwatch_metric_alarm" "healthyhosts" {
  alarm_name          = "${var.project}_Unhealthy_Hosts"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 120
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.healthyhosts.arn]
  ok_actions          = [aws_sns_topic.healthyhosts.arn]
  dimensions = {
    TargetGroup  = module.alb.target_groups.asg_host.arn_suffix
    LoadBalancer = module.alb.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "cpuutilization" {
  alarm_name          = "${var.project}_CPU_Average_is_High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "High CPU usage by TSG Tech Radar App Instance"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.cpuutilization.arn]
  ok_actions          = [aws_sns_topic.cpuutilization.arn]
  dimensions = {
    AutoScalingGroupName = module.asg_host.autoscaling_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "highresponsetime" {
  alarm_name          = "${var.project}_High_Response_Time"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 3
  alarm_description   = "Response time for Tech Radar app is high"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.highresponsetime.arn]
  ok_actions          = [aws_sns_topic.highresponsetime.arn]
  dimensions = {
    TargetGroup  = module.alb.target_groups.asg_host.arn_suffix
    LoadBalancer = module.alb.arn_suffix

  }
}
