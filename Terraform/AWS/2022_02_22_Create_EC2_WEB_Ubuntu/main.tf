provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key =  "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}


#3 create Instance from AMI (Ubuntu)

resource "aws_instance" "PRD-R3al-WEB1" {
   ami = "ami-0015a39e4b7c0966f"  #ubuntu 20.04
    instance_type = "t2.small"
    subnet_id ="subnet-07dd807442f2f5bce" # prd
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.153"
    vpc_security_group_ids = [
       "sg-03cfbd539b31d4d25",
       "sg-0734354e8a2df6ec8"   
    ] 
            tags = {
            Name = "PRD-R3al-WEB1"
            Environment= "PRD"

        }
    volume_tags = {
        Name = "PRD-R3al-WEB1"
        Environment = "PRD"
        SnapShot-Backup = "Daily-once"
        }

}