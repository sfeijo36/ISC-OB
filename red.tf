resource "aws_vpc" "vpc-obligatorio" {
  cidr_block       = "172.16.0.0/16"
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
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.vpc-obligatorio.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.vpc-obligatorio.id
  cidr_block = "172.16.2.0/24"
  availability_zone = "us-east-1b"
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
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet-Gateway.id
  }


  tags = {
    Name = "route-table"
  }
}