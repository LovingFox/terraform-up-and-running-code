terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "terraform-asg-bucket-revyakin"
    key            = "workspaces-example/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-asg-table-revyakin"
    encrypt        = true

  }
}

resource "aws_instance" "example" {
  ami           = "ami-08d70e59c07c61a3a"

  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"

}

