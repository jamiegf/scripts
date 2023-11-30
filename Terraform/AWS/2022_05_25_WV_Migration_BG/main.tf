
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}





#create EC2 instance


resource "aws_instance" "DEV-BG-WEB1" {
    ami = "ami-051a7c9f295c0a4a4" #Miomni Windows 2016 Base AMI
    instance_type = "t3.large"  #2 cores, 8GB ram
    subnet_id ="subnet-016803066ec73fa2c" # 
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.211"
        vpc_security_group_ids = [
       "sg-0d351db1e9ba7a33e"
              ]
         root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "DEV-BG-WEB1"
            Environment= "BG"
         
        }
    volume_tags = {
        Name = "DEV-BG-WEB1",
        Environment = "BG",
        SnapShot-Backup = "Daily-once"
        }

}


resource "aws_instance" "DEV-BG-APP1" {
    ami = "ami-051a7c9f295c0a4a4" #Miomni Windows 2016 Base AMI
    instance_type = "t3.xlarge"  #4 cores, 16GB ram
    subnet_id ="subnet-016803066ec73fa2c" # 
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.212"
        vpc_security_group_ids = [
       "sg-0d351db1e9ba7a33e"
              ]
         root_block_device {
    volume_size = 120 # in GB 
         }
            tags = {
            Name = "DEV-BG-APP1"
            Environment= "BG"
         
        }
    volume_tags = {
        Name = "DEV-BG-APP1",
        Environment = "BG",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "DEV-BG-SQL1" {
    ami = "ami-051a7c9f295c0a4a4" #Miomni Windows 2016 Base AMI
    instance_type = "t3.xlarge"  #2 cores, 8GB ram
    subnet_id ="subnet-016803066ec73fa2c" # 
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.213"
        vpc_security_group_ids = [
       "sg-0d351db1e9ba7a33e"
              ]
         root_block_device {
    volume_size = 100 # in GB 
         }
            tags = {
            Name = "DEV-BG-SQL1"
            Environment= "BG"
         
        }
    volume_tags = {
        Name = "DEV-BG-SQL1",
        Environment = "BG",
        SnapShot-Backup = "Daily-once"
        }

}