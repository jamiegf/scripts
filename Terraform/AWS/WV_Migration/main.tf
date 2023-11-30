provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDGKEEUXWI"
  secret_key =  "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"
}


resource "aws_instance" "STG-Sports-WEB1" {
    ami = "ami-0d50f60bcd39befcf" #Windows 2016 Base AMI
    instance_type = "t2.large"  #2 cores, 8GB ram
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.161"
        vpc_security_group_ids = [
        "sg-0d62d21ae4ec57314",
        "sg-035b5502266478545"
        ]
         root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "STG-Sports-WEB1"
            Environment= "STG"
         
        }
    volume_tags = {
        Name = "STG-Sports-WEB1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "STG-INPLAY-WEB1" {
    ami = "ami-0d50f60bcd39befcf" #Windows 2016 Base AMI
    instance_type = "t2.large"  #2 cores, 8GB ram
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.171"
        vpc_security_group_ids = [
         "sg-0d62d21ae4ec57314",
        "sg-035b5502266478545"
        ]
         root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "STG-INPLAY-WEB1"
            Environment= "STG"
         
        }
    volume_tags = {
             Name = "STG-INLPLAY-WEB1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "STG-RACE-WEB1" {
    ami = "ami-0d50f60bcd39befcf" #Windows 2016 Base AMI
    instance_type = "t2.large"  #2 cores, 8GB ram
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.181"
        vpc_security_group_ids = [
        "sg-0d62d21ae4ec57314",
        "sg-035b5502266478545"
        ]
                 root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "STG-RACE-WEB1"
            Environment= "STG"
         
        }
    volume_tags = {
                   Name = "STG-RACE-WEB1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }

}
resource "aws_instance" "STG-RACE-APP1" {
    ami = "ami-0d50f60bcd39befcf" #Windows 2016 Base AMI
    instance_type = "t2.large"  #2 cores, 8GB ram
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.188"
        vpc_security_group_ids = [
        "sg-07104b98b4e146403",
        "sg-035b5502266478545"
        ]

                 root_block_device {
    volume_size = 60 # in GB 
         }
            tags = {
            Name = "STG-RACE-APP1"
            Environment= "STG"
         
        }
    volume_tags = {
                   Name = "STG-RACE-APP1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "STG-Miomni-SQL1" {
    ami = "ami-0d50f60bcd39befcf" #Windows 2016 Base AMI
    instance_type = "t2.large"  #2 cores, 8GB ram
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.200"
        vpc_security_group_ids = [
         "sg-07104b98b4e146403",
        "sg-035b5502266478545"
        ]

                 root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "STG-Miomni-SQL1"
            Environment= "STG"
         
        }
    volume_tags = {
                   Name = "STG-Miomni-SQL1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }

}