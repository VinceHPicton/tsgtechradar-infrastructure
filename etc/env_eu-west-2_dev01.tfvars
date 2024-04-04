environment = "dev01"
region      = "eu-west-2"

vpc_id = "vpc-03b13b4ff6b52ade6"

hosts = {
  dev = {
    name          = "dev"
    instance_type = "t3.medium"
    asg_min_size  = 1
    asg_max_size  = 1
  }
  stable = {
    name          = "stable"
    instance_type = "t3.medium"
    asg_min_size  = 1
    asg_max_size  = 1
  }
}
