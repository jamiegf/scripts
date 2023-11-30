provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}


resource "aws_instance" "PRD-Miomni-WEB1" {
    ami = "ami-0fa2f3675aba21716" #Miomni Windows 2016 Base AMI
    instance_type = "t2.medium"  #2 cores, 4GB ram
    subnet_id ="subnet-07dd807442f2f5bce" # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.151"
        vpc_security_group_ids = [
        "sg-0a337dfc9fa26bef0" #jamiegf home rdp
        
        ]
         root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "PRD-Miomni-WEB1"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-Miomni-WEB1",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "PRD-Miomni-WEB2" {
    ami = "ami-0fa2f3675aba21716" #Miomni Windows 2016 Base AMI
    instance_type = "t2.medium"  #2 cores, 4GB ram
    subnet_id ="subnet-07dd807442f2f5bce" # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.152"
        vpc_security_group_ids = [
        "sg-0a337dfc9fa26bef0" # jamiegf rdp home
        
        ]
         root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "PRD-Miomni-WEB2"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-Miomni-WEB2",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}