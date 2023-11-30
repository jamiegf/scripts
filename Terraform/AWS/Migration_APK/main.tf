provider "aws" {
  region     = "us-west-1" # N California
  access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}

#create VPV, Subnet, INternet Gateway, Route Table, Route table's last resort
# create VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "WEB" {
  cidr_block = "10.191.0.0/16"

  tags= {
        Name = "WEB VPC"
  }
}


# Public Subnet with Default Route to Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "WEB-1" {
  vpc_id     = aws_vpc.WEB.id
  cidr_block = "10.191.1.0/24"

  tags = {
    Name = "WEB-1"
  }
}

resource "aws_subnet" "WEB-2" {
  vpc_id     = aws_vpc.WEB.id
  cidr_block = "10.191.2.0/24"

  tags = {
    Name = "WEB-2"
  }
}

# Main Internal Gateway for VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "WEB-IGW" {
  vpc_id = aws_vpc.WEB.id

  tags = {
    Name = "WEB-IGW"
  }
}

# Route Table for Public Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "WEB" {
  vpc_id = aws_vpc.WEB.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.WEB-IGW.id
  }

  tags = {
    Name = "WEB Route Table"
  }
}



