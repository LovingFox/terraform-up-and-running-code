terraform {
  required_version = ">= 0.12"
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "terraform-asg-bucket-revyakin"
    key = "global/s3/terraform.tfstate"
    region = "us-west-2"
    # Замените это именем своей таблицы DynamoDB!
    dynamodb_table = "terraform-asg-table-revyakin"
    encrypt = true
  }
}

provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name

  // This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production
  // usage
  force_destroy = true

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
