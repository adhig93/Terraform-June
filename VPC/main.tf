resource "aws_vpc" "vpc" {
	cidr_block = var.vpc-cidr
	tags = {
		Name = "terraform-vpc"
	}
}

resource "aws_subnet" "publicsub" {
	vpc_id = aws_vpc.vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = var.availability-zone
	tags = {
		Name = "terraform-publicsub"
	}
}

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.vpc.id
	tags = {
		Name = "terraform-igw"
	}
}

resource "aws_route_table" "routetable" {
	vpc_id = aws_vpc.vpc.id
	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.igw.id
	}
	tags = {
		Name = "terraform-crt"
	}
}

resource "aws_route_table_association" "crt-public" {
	subnet_id = aws_subnet.publicsub.id
	route_table_id = aws_route_table.routetable.id
}

resource "aws_security_group" "sg" {
	vpc_id = aws_vpc.vpc.id
	egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
	ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
	tags = {
		Name = "terraform-sg"
	}
}

resource "aws_instance" "instance" {
	subnet_id = aws_subnet.publicsub.id	
	vpc_security_group_ids = [aws_security_group.sg.id]
	instance_type = var.ec2-type
	ami = "ami-09e67e426f25ce0d7"
	key_name = "terraform"
	tags = {
		Name = "terraform-instance"
	}
}