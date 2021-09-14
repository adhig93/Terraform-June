resource "aws_security_group" "sg" {
	vpc_id = var.vpc_id
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

variable "vpc_id" {
	type = string
}

output "sg_id_cm" {
	value = aws_security_group.sg.id
}