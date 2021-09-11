provider "aws" {
  region = "us-east-1"
}

terraform {
	backend "s3" {
		bucket = "s3-bucket-for-remote-state-tf-1234"
		key = "terraform/backend/terraform.tfstate"
		region = "us-east-1"
		
		dynamodb_table = "dynamodb-remote-state"
		encrypt = true
	}
}


resource "aws_instance" "my-instance" {
	ami = "ami-09e67e426f25ce0d7"
	instance_type = "t2.micro"
	key_name = "terraform"
	tags = {
		Name = "terraform-ec2"
	}
}