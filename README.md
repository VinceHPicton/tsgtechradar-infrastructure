# tsgtechradar-infrastructure

Terraform Components for TSG Tech Radar

## AWS account IDs where the app is hosted
See: group_prod.tfvars:
aws_account_id     = "836546930053" => production
dev_aws_account_id = "302653724645" => dev

## Install pre-commit hooks

```sh
pre-commit install
```

## Run Checkov Locally

Install checkov CLI - <https://www.checkov.io/2.Basics/Installing%20Checkov.html>

```sh
checkov --config-file .checkov.yml -d .
```

## Local Terraform

```sh
bin/terraform.sh -p tsgtr --region eu-west-2 -c template -g dev --environment dev01 --action plan
```

## Connecting to DB

You will need to obtain the RDS DB username and password from Secrets Manager first

From one of the EC2 instances:

```sh
psql --port=5432 --username=postgres --dbname=postgres --host="${DB_NAME}"
```
