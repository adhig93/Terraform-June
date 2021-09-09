provider "aws" {
	region = "us-east-1"
}

variable "instance-names" {
	type = set(string)
	default = ["0","1","2","3","4"]
}

resource "aws_instance" "my-instance" {
	instance_type = "t2.micro"
	ami = "ami-09e67e426f25ce0d7"
	key_name = "terraform"
	
	#using for_each
	for_each = var.instance-names
	tags = {
		Name = "foreach-ec2 ${each.key}"
	}
	
	#using count
	count = 5
	tags = {
		Name = "count-ec2 ${count.index}"
	}
}

