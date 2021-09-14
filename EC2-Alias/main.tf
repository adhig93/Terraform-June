provider "aws" {
	region = "us-east-1"
}

provider "aws" {
	alias = "mumbai"
	region = "ap-south-1"
}


resource "aws_instance" "my-instance" {
	provider = aws.mumbai
	ami = "ami-0c1a7f89451184c8b"
	instance_type = "t2.micro"
	tags = {
		Name = "terraform-ec2"
	}
}