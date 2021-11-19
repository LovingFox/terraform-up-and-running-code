terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name  = var.cluster_name

  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  min_size           = 1
  max_size           = 1
  enable_autoscaling = false

  subnet_ids        = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
