terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  server_text = var.server_text

  environment = var.environment

  mysql_config = var.mysql_config

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}
