provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}

#1 clone current dev environment (centos)
resource "aws_ami_from_instance" "Clone_of_DEV-MiB2C-APP1" {
    name = "Clone_of_DEV-MiB2C-APP1"
    source_instance_id = " i-05804a063b794a3a0"
    tags = {
        Name = "Clone_of_DEV-MiB2C-APP1"
        }

}

#2 clone currrent dev environment (Windows)
resource "aws_ami_from_instance" "DEV-MiB2C-WEB1" {
    name = "DEV-MiB2C-WEB1"
    source_instance_id = "i-06ee3423a8fbab943"
    tags = {
        Name = "Clone_of_DEV-MiB2C-WEB1"
        }

}

#3 create Instance from AMI (centos)

resource "aws_instance" "STG-MiB2C-APP1" {
   ami = aws_ami_from_instance.Clone_of_DEV-MiB2C-APP1.id #centos clone of dev
    instance_type = "t3.small"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.103"
    vpc_security_group_ids = [
        "sg-0d62d21ae4ec57314", 
        "sg-00a2be6400569c933"   
    ] 
            tags = {
            Name = "STG-MiB2C-APP1"
            Environment= "STG"

        }
    volume_tags = {
        Name = "STG-MiB2C-APP1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}

#allocate IP centos
resource "aws_eip_association" "STG-MiB2C-APP1" {
  instance_id   = aws_instance.STG-MiB2C-APP1.id
  allocation_id = "eipalloc-03171b584691fd264"
}


#create Instance from AMI (Windows)

resource "aws_instance" "STG-MiB2C-WEB1" {
    ami = "ami-06f229aee4f17c1d0" #dev-1 (windows) clone
    instance_type = "t2.large"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.104"
    vpc_security_group_ids = [
        "sg-035b5502266478545", 
        "sg-0d62d21ae4ec57314"
    ]
            tags = {
            Name = "STG-MiB2C-WEB1"
            Environment= "STG"
       
        }
    volume_tags = {
        Name = "STG-MiB2C-WEB1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}


#allocate IP (Windows)
resource "aws_eip_association" "STG-MiB2C-WEB1" {
  instance_id   = aws_instance.STG-MiB2C-WEB1.id
  allocation_id = "eipalloc-09a8f083216eaeff9"
}