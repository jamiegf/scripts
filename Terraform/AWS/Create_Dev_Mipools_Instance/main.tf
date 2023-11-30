provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key = "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}







resource "aws_instance" "DEV-Mipool-SQL1" {
    #ami = "ami-0194c3e07668a7e36" # ubuntu
    ami = "ami-06db9d8fca38be745" # Windows 2022
    instance_type = "t3.large"
    subnet_id ="subnet-07f7bdc4a0ca76f9a"
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.10.101"
        vpc_security_group_ids = [
       "sg-0d351db1e9ba7a33e"
              ]
         root_block_device {
    volume_size = 100 # in GB 
         }
                      
            tags = {
            Name = "DEV-Mipool-SQL1",
            Environment = "Dev",
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Environment = "Dev",
        SnapShot-Backup = "Daily-once"
        }


}