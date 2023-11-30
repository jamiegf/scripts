


#Create the VPC
 resource "aws_vpc" "stg" {                # Creating VPC here
   cidr_block       = var.stg_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
     tags = {
    Name = "STG VPC"
  }
 }
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "stg_IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.stg.id               # vpc_id will be generated after we create VPC
      tags = {
    Name = "STG IGW"
  }
 }
 #Create a Public Subnets.
 resource "aws_subnet" "stg_publicsubnets" {    # Creating Public Subnets
   vpc_id =  aws_vpc.stg.id   # CIDR block of public subnets
   cidr_block = "${var.stg_public_subnets}" 
     tags = {
    Name = "STG Public Subnet"
  }      
 }
 #Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "stg_privatesubnets" {
   vpc_id =  aws_vpc.stg.id
   cidr_block = "${var.stg_private_subnets}"          # CIDR block of private subnets
     tags = {
    Name = "STG Private Subnet"
  }
 }
 #Route table for Public Subnet's
 resource "aws_route_table" "stg_PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.stg.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.stg_IGW.id
    
     }
       tags = {
    Name = "STG Public Route Table"
  }
 }
 #Route table for Private Subnet's
 resource "aws_route_table" "stg_PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.stg.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.stg_NATgw.id
   }
     tags = {
    Name = "STG Private Route Table"
  }
 }
 #Route table Association with Public Subnet's
 resource "aws_route_table_association" "stg_PublicRTassociation" {
    subnet_id = aws_subnet.stg_publicsubnets.id
    route_table_id = aws_route_table.stg_PublicRT.id
 }
 #Route table Association with Private Subnet's
 resource "aws_route_table_association" "stg_PrivateRTassociation" {
    subnet_id = aws_subnet.stg_privatesubnets.id
    route_table_id = aws_route_table.stg_PrivateRT.id
 }
 resource "aws_eip" "stg_nateIP" {
   vpc   = true
     tags = {
    Name = "STG NAT Gateway EIP"
  }
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "stg_NATgw" {
   allocation_id = aws_eip.stg_nateIP.id
   subnet_id = aws_subnet.stg_publicsubnets.id
     tags = {
    Name = "STG NAT Gateway"
  }
 }