provider "aws" {
	region = "us-east-1"
}

module "to-create-ec2" {
	source = "./modules/create_ec2"
	ami_id = "ami-09e67e426f25ce0d7"
	instance_type = "t2.micro"
	sg_id = module.to-create-sg.sg_id_cm
}

module "to-create-sg" {
	source = "./modules/create_sg"
	vpc_id = "vpc-2471e659"
}

output "publicip" {
	value = module.to-create-ec2.public_ip_cm
}

output "id" {
	value = module.to-create-ec2.id_cm
}