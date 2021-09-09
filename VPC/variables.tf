variable "region" {
	default = "us-east-1"
}

variable "vpc-cidr" {
	default = "10.0.0.0/16"
}

variable "availability-zone" {
	default = "us-east-1a"
}

variable "ec2-type" {
	default = "t2.micro"
}