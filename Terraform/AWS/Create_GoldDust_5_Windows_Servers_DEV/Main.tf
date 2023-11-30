provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}


#create Instance from AMI (Windows)

resource "aws_instance" "DEV-GDUST-WEB1" {
    ami = "ami-0f34584723e6f6fa9" # windows server 2019, DC edition
    instance_type = "t2.medium"
    subnet_id =" subnet-016803066ec73fa2c" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.151"
    vpc_security_group_ids = [
            "sg-0980c9d19fe695094", #cristi rdp
            "sg-0c4eec81073e964b7", #dev web
            "sg-0d351db1e9ba7a33e", #jamiegf
            "sg-07d2d6b9682deedfc" # dinesh
    ]
            tags = {
            Name = "DEV-GDUST-WEB1"
            Environment= "DEV"
            }
    volume_tags = {
        Environment = "DEV"
        }

}



#create Instance from AMI (Windows)

resource "aws_instance" "DEV-GDUST-APP1" {
    ami = "ami-0f34584723e6f6fa9" # windows server 2019, DC edition
    instance_type = "t2.medium"
    subnet_id =" subnet-016803066ec73fa2c" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.152"
    vpc_security_group_ids = [
            "sg-0980c9d19fe695094", #cristi rdp
            "sg-0c4eec81073e964b7", #dev web
            "sg-0d351db1e9ba7a33e", #jamiegf
            "sg-07d2d6b9682deedfc" # dinesh
    ]
            tags = {
            Name = "DEV-GDUST-APP1"
            Environment= "DEV"
            }
    volume_tags = {
        Environment = "DEV"
        }

}


#create Instance from AMI (Windows)

resource "aws_instance" "DEV-GDUST-DB1" {
    ami = "ami-0f34584723e6f6fa9" # windows server 2019, DC edition
    instance_type = "t2.medium"
    subnet_id =" subnet-016803066ec73fa2c" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.153"
    vpc_security_group_ids = [
            "sg-0980c9d19fe695094", #cristi rdp
            "sg-0c4eec81073e964b7", #dev web
            "sg-0d351db1e9ba7a33e", #jamiegf
            "sg-07d2d6b9682deedfc" # dinesh
    ]
            tags = {
            Name = "DEV-GDUST-DB1"
            Environment= "DEV"
            }
    volume_tags = {
        Environment = "DEV"
        }

}


#create Instance from AMI (Windows)

resource "aws_instance" "DEV-GDUST-MW1" {
    ami = "ami-0f34584723e6f6fa9" # windows server 2019, DC edition
    instance_type = "t2.medium"
    subnet_id =" subnet-016803066ec73fa2c" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.154"
    vpc_security_group_ids = [
            "sg-0980c9d19fe695094", #cristi rdp
            "sg-0c4eec81073e964b7", #dev web
            "sg-0d351db1e9ba7a33e", #jamiegf
            "sg-07d2d6b9682deedfc" # dinesh
    ]
            tags = {
            Name = "DEV-GDUST-MW1"
            Environment= "DEV"
            }
    volume_tags = {
        Environment = "DEV"
        }

}


