terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

module "alb" {
  source = "../../modules/networking/alb"

  alb_name   = var.alb_name

  subnet_ids = data.aws_subnet_ids.default.ids
}
