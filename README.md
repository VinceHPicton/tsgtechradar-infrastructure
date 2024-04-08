# tsgtechradar-infrastructure

Terraform Components for TSG Tech Radar

## Install pre-commit hooks

```sh
pre-commit install
```

## Run Checkov Locally

Install checkov CLI - <https://www.checkov.io/2.Basics/Installing%20Checkov.html>

```sh
checkov --config-file .checkov.yml -d .
```

## Local Terraform Run

```sh
bin/terraform.sh -p tsgtr --region eu-west-2 -c template -g dev --environment dev01 --action plan
```
