
#provider "aws" {
#   region = "us-west-1"
#	 access_key = "AKIAUVBUS6JDGKEEUXWI"
#  secret_key =  "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"
# }

#Create the VPC
 resource "aws_vpc" "Main" {                # Creating VPC here
   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
     tags = {
    Name = "Main VPC"
  }
 }
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
      tags = {
    Name = "Main IGW"
  }
 }
 #Create a Public Subnets.
 resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
   vpc_id =  aws_vpc.Main.id   # CIDR block of public subnets
   cidr_block = "${var.public_subnets}" 
     tags = {
    Name = "Public Subnet"
  }      
 }
  resource "aws_subnet" "publicsubnet2" {    # Creating Public Subnets
   vpc_id =  aws_vpc.Main.id   # CIDR block of public subnets
   cidr_block = "${var.public_subnets}" 
     tags = {
    Name = "Public Subnet2"
  }      
 }
 #Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.private_subnets}"          # CIDR block of private subnets
     tags = {
    Name = "Private Subnet"
  }
 }
 #Route table for Public Subnet's
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
    
     }
       tags = {
    Name = "Public Route Table"
  }
 }
 #Route table for Private Subnet's
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
     tags = {
    Name = "Private Route Table"
  }
 }
 #Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnets.id
    route_table_id = aws_route_table.PublicRT.id
 }
 #Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnets.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
     tags = {
    Name = "NAT Gateway EIP"
  }
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets.id
     tags = {
    Name = "Main NAT Gateway"
  }
 }

 # create security group
resource "aws_security_group" "allow_jamiegf" {
  name        = "allow_jamiegf"
  description = "Allow jamiegf SSH inbound traffic"
  vpc_id      = aws_vpc.Main.id

  ingress {
    description      = "SSH from Jamiegf"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["81.174.157.230/32"] #[aws_vpc.WEB.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_jamiegf"
  }
}



#create EC2 instance


resource "aws_instance" "PRD-APK-WEB1" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.medium"  #2 cores, 4GB ram
    subnet_id =aws_subnet.publicsubnets.id # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.192.7.11"
        vpc_security_group_ids = [
        aws_security_group.allow_jamiegf.id #jamiegf home rdp created above
        
        ]
         root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "PRD-APK-WEB1"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-APK-WEB1",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}