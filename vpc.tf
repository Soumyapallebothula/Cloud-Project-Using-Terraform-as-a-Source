# create VPC
resource "aws_vpc" "my_app" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = "demo_vpc"
  }
}
#creating public subnet
resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.my_app.id
  cidr_block              = var.subnet_cidr


  tags = {
    Name = "public-subnet"
  }
}

#creating aws_internet_gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_app.id

  tags = {
    Name = "demo_gateway"
  }
}
# Create Route table for webservers
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.my_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "demo_route"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.web_rt.id
}

#creating private subnet
resource "aws_subnet" "priv-subnet" {
  vpc_id     = aws_vpc.my_app.id
  cidr_block = var.priv_cidr

  tags = {
    Name = "private-subnet"
  }
}

#importing the main route_table of vpc
resource "aws_route_table" "main_rt" {
  vpc_id = "vpc-0ec71c0cea19e0d39"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.bastionhost.id
}
  tags = {
    Name = "main_rt"
  }
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.priv-subnet.id
  route_table_id = aws_route_table.main_rt.id
  }
  resource "aws_subnet" "subnet1" {
    vpc_id            = aws_vpc.my_app.id
    cidr_block        = var.subnet1_cidr
    availability_zone = "us-east-1a"

    tags = {
      Name = "subnet1"
    }
  }
  resource "aws_subnet" "subnet2" {
    vpc_id            = aws_vpc.my_app.id
    cidr_block        = var.subnet2_cidr
    availability_zone = "us-east-1b"

    tags = {
      Name = "subnet2"
    }
  }
