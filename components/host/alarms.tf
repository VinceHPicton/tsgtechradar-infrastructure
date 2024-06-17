resource "aws_cloudwatch_metric_alarm" "healthyhosts" {
  alarm_name          = "Unhealthy Hosts"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = 120
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.healthyhosts.arn]
  ok_actions          = [aws_sns_topic.healthyhosts.arn]
  dimensions = {
    TargetGroup  = module.alb.target_groups.arn
    LoadBalancer = module.alb.arn_suffix
  }
}