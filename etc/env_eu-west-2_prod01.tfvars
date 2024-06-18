environment = "prod01"
region      = "eu-west-2"

domain_name = "tsgtechradar.bjss.com"

vpc_id = "vpc-0276830dfaa7f3009"

asg_config = {
  instance_type = "t3.medium"
  asg_min_size  = 1
  asg_max_size  = 1
}

database_config = {
  db_instance_type     = "db.t3.micro"
  db_allocated_storage = 5
  db_snapshot_id       = ""
}

jira_ssm_parameter_name = "/jira/mvp"

github_oidc_arn        = "arn:aws:iam::836546930053:oidc-provider/token.actions.githubusercontent.com"
