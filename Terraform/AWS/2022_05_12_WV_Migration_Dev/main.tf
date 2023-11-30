
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDGKEEUXWI"
  secret_key =  "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"
}





#create EC2 instance


resource "aws_instance" "DEV-Miomni-WEB1" {
    ami = "ami-051a7c9f295c0a4a4" #Miomni Windows 2016 Base AMI
    instance_type = "t3.large"  #2 cores, 8GB ram
    subnet_id ="subnet-016803066ec73fa2c" # 
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.195"
        vpc_security_group_ids = [
       "sg-0d351db1e9ba7a33e"
              ]
         root_block_device {
    volume_size = 120 # in GB 
         }
            tags = {
            Name = "DEV-Miomni-WEB1"
            Environment= "DEV"
         
        }
    volume_tags = {
        Name = "DEV-Miomni-WEB1",
        Environment = "DEV",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "DEV-Miomni-SQL1" {
    ami = "ami-051a7c9f295c0a4a4" #windows server 2016
    instance_type = "t2.medium"  #1 cores, 2GB ram
    subnet_id ="subnet-016803066ec73fa2c" # 
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.196"
        vpc_security_group_ids = [
        "sg-0d351db1e9ba7a33e"
        
              ]
         root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "DEV-Miomni-SQL1"
            Environment= "DEV"
         
        }
    volume_tags = {
        Name = "DEV-Miomni-SQL1",
        Environment = "DEV",
        SnapShot-Backup = "Daily-once"
        }

}