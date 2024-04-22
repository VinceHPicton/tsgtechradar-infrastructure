terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.45"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3"
    }
  }
}
