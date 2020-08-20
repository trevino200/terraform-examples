# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

# Configure the Dome9 Provider
provider "dome9" {
  dome9_access_id  = var.access_id
  dome9_secret_key = var.secret_key
}
