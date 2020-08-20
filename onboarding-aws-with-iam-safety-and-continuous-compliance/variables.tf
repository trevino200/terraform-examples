variable "aws_region" {
  default = "us-west-2"
}

variable "access_id" {
  description = "CloudGuard Dome9 API Access ID"
}

variable "secret_key" {
  description = "CloudGuard Dome9 API Secret Key"
}

variable "connect_iam_safety" {
  type = bool
  description = "IAM Safety Onboarding. Enter true/false"
}

variable "bundle_id" {
  description = "Compliance rules bundle ID"
  default     = -5 # CloudGuard Dome9 best parctices
  type        = number
}

locals {
  policies = [
    aws_iam_policy.dome9_read_only_policy.arn,
    aws_iam_policy.dome9_write_policy.arn,
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/AmazonInspectorReadOnlyAccess"
  ]
}
