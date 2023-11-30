

data "aws_availability_zones" "available" {}

resource "aws_vpc" "dev" {
  cidr_block           = "${var.dev_vpc_cidr}.0.0/16"
  enable_dns_hostnames = true
  tags =  {
    Name = "DEV VPC"
  }
}
#Create Public Subnets
resource "aws_subnet" "dev_public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.dev.id}"
  cidr_block = "${var.dev_vpc_cidr}.${1+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "DEV Public Subnet${count.index}"
  }
}
#Create Private Subnets
resource "aws_subnet" "dev_private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.dev.id}"
  cidr_block = "${var.dev_vpc_cidr}.${100+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "DEV Private Subnet${count.index}"
  }
}
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "dev_IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.dev.id               # vpc_id will be generated after we create VPC
      tags = {
    Name = "DEV IGW"
  }
 }
 #Route table for Public Subnets
 resource "aws_route_table" "dev_PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.dev.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.dev_IGW.id
    
     }
       tags = {
    Name = "DEV Public Route Table"
  }
 }
  #Route table Association with Public Subnet's
 resource "aws_route_table_association" "dev_PublicRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.dev_public_subnet[count.index].id
    route_table_id = aws_route_table.dev_PublicRT.id
 }

#create Elastic IP
 resource "aws_eip" "dev_nateIP" {
   vpc   = true
     tags = {
    Name = "DEV NAT Gateway EIP"
  }
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "dev_NATgw" {
   allocation_id = aws_eip.dev_nateIP.id
   subnet_id = aws_subnet.dev_public_subnet[0].id   # 0 will use first public subnet created
     tags = {
    Name = "DEV NAT Gateway"
  }
 }
  #Route table for Private Subnet's
 resource "aws_route_table" "dev_PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.dev.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.dev_NATgw.id
   }
     tags = {
    Name = "DEV Private Route Table"
  }
 }
  #Route table Association with Private Subnet's
 resource "aws_route_table_association" "dev_PrivateRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.dev_private_subnet[count.index].id
    route_table_id = aws_route_table.dev_PrivateRT.id
 }


 ########################################
 ############### STG ####################
#####################################################


resource "aws_vpc" "stg" {
  cidr_block           = "${var.stg_vpc_cidr}.0.0/16"
  enable_dns_hostnames = true
  tags =  {
    Name = "STG VPC"
  }
}
#Create Public Subnets
resource "aws_subnet" "stg_public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.stg.id}"
  cidr_block = "${var.stg_vpc_cidr}.${1+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "STG Public Subnet${count.index}"
  }
}
#Create Private Subnets
resource "aws_subnet" "stg_private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.stg.id}"
  cidr_block = "${var.stg_vpc_cidr}.${100+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "STG Private Subnet${count.index}"
  }
}
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "stg_IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.stg.id               # vpc_id will be generated after we create VPC
      tags = {
    Name = "STG IGW"
  }
 }
 #Route table for Public Subnets
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
  #Route table Association with Public Subnet's
 resource "aws_route_table_association" "stg_PublicRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.stg_public_subnet[count.index].id
    route_table_id = aws_route_table.stg_PublicRT.id
 }

#create Elastic IP
 resource "aws_eip" "stg_nateIP" {
   vpc   = true
     tags = {
    Name = "STG NAT Gateway EIP"
  }
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "stg_NATgw" {
   allocation_id = aws_eip.stg_nateIP.id
   subnet_id = aws_subnet.stg_public_subnet[0].id   # 0 will use first public subnet created
     tags = {
    Name = "STG NAT Gateway"
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
  #Route table Association with Private Subnet's
 resource "aws_route_table_association" "stg_PrivateRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.stg_private_subnet[count.index].id
    route_table_id = aws_route_table.stg_PrivateRT.id
 }

 ######################################################################################################################
 ################################### PRD #############################################################################
 ################################################################################################################################

 resource "aws_vpc" "prd" {
  cidr_block           = "${var.prd_vpc_cidr}.0.0/16"
  enable_dns_hostnames = true
  tags =  {
    Name = "PRD VPC"
  }
}
#Create Public Subnets
resource "aws_subnet" "prd_public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.prd.id}"
  cidr_block = "${var.prd_vpc_cidr}.${1+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "PRD Public Subnet${count.index}"
  }
}
#Create Private Subnets
resource "aws_subnet" "prd_private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.prd.id}"
  cidr_block = "${var.prd_vpc_cidr}.${100+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "PRD Private Subnet${count.index}"
  }
}
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "prd_IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.prd.id               # vpc_id will be generated after we create VPC
      tags = {
    Name = "PRD IGW"
  }
 }
 #Route table for Public Subnets
 resource "aws_route_table" "prd_PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.prd.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.prd_IGW.id
    
     }
       tags = {
    Name = "PRD Public Route Table"
  }
 }
  #Route table Association with Public Subnet's
 resource "aws_route_table_association" "prd_PublicRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.prd_public_subnet[count.index].id
    route_table_id = aws_route_table.prd_PublicRT.id
 }

#create Elastic IP
 resource "aws_eip" "prd_nateIP" {
   vpc   = true
     tags = {
    Name = "PRD NAT Gateway EIP"
  }
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "prd_NATgw" {
   allocation_id = aws_eip.prd_nateIP.id
   subnet_id = aws_subnet.prd_public_subnet[0].id   # 0 will use first public subnet created
     tags = {
    Name = "PRD NAT Gateway"
  }
 }
  #Route table for Private Subnet's
 resource "aws_route_table" "prd_PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.prd.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.prd_NATgw.id
   }
     tags = {
    Name = "PRD Private Route Table"
  }
 }
  #Route table Association with Private Subnet's
 resource "aws_route_table_association" "prd_PrivateRTassociation" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = aws_subnet.prd_private_subnet[count.index].id
    route_table_id = aws_route_table.prd_PrivateRT.id
 }