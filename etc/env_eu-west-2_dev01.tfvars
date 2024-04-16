environment = "dev01"
region      = "eu-west-2"

domain_name = "dev.tsgtechradar.bjss.com"

vpc_id = "vpc-03b13b4ff6b52ade6"

asg_config = {
  instance_type = "t3.medium"
  asg_min_size  = 1
  asg_max_size  = 1
}

database_config = {
  db_instance_type     = "db.t3.micro"
  db_allocated_storage = 5
  db_snapshot_id       = "tsgtr-dev01-database-init"
}

jira_ssm_parameter_name = "/jira/mvp"

artefact_bucket = "tsgtr-302653724645-eu-west-2-tdev-ci-tfaps-main-cp"
