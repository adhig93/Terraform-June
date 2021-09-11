provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg" {
	vpc_id = "vpc-2471e659"
    egress {
		from_port        = 0
		to_port          = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
	ingress {
		from_port        = 0
		to_port          = 0
		protocol         = "-1"
		cidr_blocks      = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
	tags = {
		Name = "terraform-sg"
	}
}

resource "aws_instance" "my-instance" {
	ami = "ami-09e67e426f25ce0d7"
	vpc_security_group_ids = [aws_security_group.sg.id]
	instance_type = "t2.micro"
	key_name = "terraform"
	tags = {
		Name = "terraform-ec2"
	}
	
	connection {
		type = "ssh"
		user = "ubuntu"
		private_key = file("./terraform.pem")
		host = aws_instance.my-instance.public_ip
	}
	
	provisioner "file" {
		source = "./get-docker.sh"
		destination = "/home/ubuntu/get-docker.sh"
	}
	
	provisioner "remote-exec" {
		inline = [
			"sudo sh /home/ubuntu/get-docker.sh",
			"sudo systemctl start docker"
		]
	}
}