provider "aws" {
  region = "us-east-1"
}

data "aws_instance" "ec2-data" {
	instance_tags = {
		Name = "terraform-ec2"
	}
}

data "aws_s3_bucket" "s3-data" {
  bucket = "test-for-data-source"
}

output "instance-id" {
	value = data.aws_instance.ec2-data.id
}

output "public_ip" {
	value = data.aws_instance.ec2-data.public_ip
}

output "arn" {
	value = data.aws_s3_bucket.s3-data.arn
}

