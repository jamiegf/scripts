provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAURFMSNIXRNWC3NJY" # miomnisports account
  secret_key =  "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"
}

#Instance - App Server
resource "aws_instance" "STG-Sea-APP1" {
   ami = "ami-04e0ebd20d57a72c1"  #Windows 22
    instance_type = "t3.large"
    subnet_id ="subnet-0485988aea7672ee6" # stg
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.10.101"
    vpc_security_group_ids = [
        "sg-074d51be2e907ae7f"
           
    ] 
             root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Sea-APP1"
            Environment= "STG"
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-Sea-APP1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}

#Instance - Admin Server
resource "aws_instance" "STG-Sea-ADM1" {
   ami = "ami-04e0ebd20d57a72c1"  #Windows 22
    instance_type = "t3.large"
    subnet_id ="subnet-0485988aea7672ee6" # stg
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.10.102"
    vpc_security_group_ids = [
        "sg-0d41dc356e8364859",
        "sg-074d51be2e907ae7f"
           
    ] 
             root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Sea-ADM1"
            Environment= "STG"
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-Sea-ADM1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}

#Instance - MW Server
resource "aws_instance" "STG-Sea-MW1" {
   ami = "ami-04e0ebd20d57a72c1"  #Windows 22
    instance_type = "t3.large"
    subnet_id ="subnet-0485988aea7672ee6" # stg
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.10.103"
    vpc_security_group_ids = [
        "sg-074d51be2e907ae7f"
           
    ] 
             root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Sea-MW1"
            Environment= "STG"
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-Sea-MW1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}

#Instance - SQL Server
resource "aws_instance" "STG-Sea-SQL1" {
   ami = "ami-04e0ebd20d57a72c1"  #Windows 22
    instance_type = "t3.large"
    subnet_id ="subnet-0485988aea7672ee6" # stg
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.10.104"
    vpc_security_group_ids = [
        "sg-074d51be2e907ae7f"
           
    ] 
             root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Sea-SQL1"
            Environment= "STG"
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-Sea-SQL1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}

#Instance - WEB Server
resource "aws_instance" "STG-Sea-WEB1" {
   ami = "ami-04e0ebd20d57a72c1"  #Windows 22
    instance_type = "t3.large"
    subnet_id ="subnet-0485988aea7672ee6" # stg
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.10.105"
    vpc_security_group_ids = [
        "sg-0d41dc356e8364859",
        "sg-074d51be2e907ae7f"
           
    ] 
             root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Sea-WEB1"
            Environment= "STG"
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-Sea-WEB1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}