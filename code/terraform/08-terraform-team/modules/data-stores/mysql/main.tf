provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

terraform {
  # Require any 0.12.x version of Terraform
  required_version = ">= 0.12"

  # Partial configuration. The rest will be filled in by Terragrunt.
  backend "s3" {}
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}
