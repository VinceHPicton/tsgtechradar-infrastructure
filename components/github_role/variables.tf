##
# Basic Required Variables for tfscaffold Components
##

variable "project" {
  type        = string
  description = "The tfscaffold project"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID (numeric)"
}

variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "group" {
  type        = string
  description = "The group variables are being inherited from (often synonymous with account short-name)"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment variables are being inherited from"
}

##
# tfscaffold variables specific to this component
##

variable "component" {
  type        = string
  description = "The variable encapsulating the name of this component"
  default     = "github_role"
}

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

# variable "deployment_execution_role_name" {
#   type        = string
#   description = "The role name for terraform to assume to perform all deployment actions in a given account. This is determined by the Landing Zone and should not normally be changed."
#   default     = "DeploymentExecution"
# }

# variable "deployment_execution_external_id" {
#   type        = string
#   description = "External Id to use when assuming AWS role for deployment"
#   default     = ""
# }

variable "github_oidc_arn" {
  type        = string
  description = "GitHub OIDC ARN"
}
