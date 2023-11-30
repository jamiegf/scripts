
provider "aws" {
   region = "us-west-1"
	 access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
 }





#create EC2 instance


resource "aws_instance" "PRD-APK-WEB2" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.small"  #2 cores, 4GB ram
    subnet_id ="subnet-05688f8c2300703b8" # Shore2
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.2.150"
        vpc_security_group_ids = [
        "sg-0e70d81aeaddba274",
        "sg-01622714b6bbbc77c"
              ]
         root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "PRD-APK-WEB2"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-APK-WEB2",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "PRD-APK-WEB3" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.small"  #1 cores, 2GB ram
    subnet_id ="subnet-09c63c3c099e85b40" # Shore2
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.5.150"
        vpc_security_group_ids = [
        "sg-0e70d81aeaddba274",
        "sg-01622714b6bbbc77c"
              ]
         root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "PRD-APK-WEB3"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-APK-WEB3",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}