resource "aws_vpc" "vpc-obligatorio" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "test-terraform-vpc"
  }
}

resource "aws_security_group" "security-group" {
    name = "security-group"
    vpc_id = aws_vpc.vpc-obligatorio.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.cidr_blocks
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.cidr_blocks
    }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.vpc-obligatorio.id
  cidr_block = var.cidr_subnet1
  availability_zone = var.azA
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.vpc-obligatorio.id
  cidr_block = var.cidr_subnet2
  availability_zone = var.azB
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-2"
  }
}

resource "aws_internet_gateway" "Internet-Gateway" {
  vpc_id = aws_vpc.vpc-obligatorio.id

  tags = {
    Name = "Internet-Gateway"
  }
}


resource "aws_default_route_table" "route-table" {
  default_route_table_id = aws_vpc.vpc-obligatorio.default_route_table_id

  route {
    cidr_block = var.cidr_blocks_rt
    gateway_id = aws_internet_gateway.Internet-Gateway.id
  }


  tags = {
    Name = "route-table"
  }
}