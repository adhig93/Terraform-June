provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "dynamodb-table-for-remote-state" {
  name           = "dynamodb-remote-state"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
}

resource "aws_s3_bucket" "s3-bucket-for-remote-state" {
  bucket = "s3-bucket-for-remote-state-tf-1234"

  versioning {
    enabled = true
  }

  force_destroy = true
}