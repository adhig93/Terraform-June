resource "aws_instance" "my-instance" {
	ami = var.ami_id
	instance_type = var.instance_type
	vpc_security_group_ids = [var.sg_id]
	key_name = "terraform"
	tags = {
		Name = "terraform-ec2"
	}
}

variable "ami_id" {
	type = string
}
variable "instance_type" {
	type = string
}
variable "sg_id" {
	type = string
}

output "public_ip_cm" {
	value = aws_instance.my-instance.public_ip
}

output "id_cm" {
	value = aws_instance.my-instance.id
}