provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}


#create Instance from AMI (Windows)

resource "aws_instance" "PRD-BG-SQL1" {
    ami = "ami-033500b90ed9aa25b" # windows
    instance_type = "m5ad.xlarge"
    subnet_id ="subnet-07dd807442f2f5bce" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.201"
    vpc_security_group_ids = [
            "sg-09ac81bb22bbf9606"  #rdp
    ]
            tags = {
            Name = "PRD-BG-SQL1"
            Environment= "PRD"
            }
    volume_tags = {
        Environment = "PRD"
        }

}



#create Instance from AMI (Windows)

resource "aws_instance" "PRD-BG-WEB1" {
    ami = "ami-033500b90ed9aa25b" # windows
    instance_type = "t3.large"
    subnet_id ="subnet-07dd807442f2f5bce" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.111"
    vpc_security_group_ids = [
        "sg-00134d79da7f39cf7",  #web
        "sg-09ac81bb22bbf9606"  #rdp
    ]
            tags = {
            Name = "PRD-BG-WEB1"
            Environment= "PRD"
            }
    volume_tags = {
        Environment = "PRD"
        }

}

#create Instance from AMI (Windows)

resource "aws_instance" "PRD-BG-APP1" {
    ami = "ami-033500b90ed9aa25b" # windows
    instance_type = "t3.xlarge"
    subnet_id ="subnet-07dd807442f2f5bce" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.112"
    vpc_security_group_ids = [
        "sg-00134d79da7f39cf7",  #web
        "sg-09ac81bb22bbf9606"  #rdp
    ]
            tags = {
            Name = "PRD-BG-APP1"
            Environment= "PRD"
            }
    volume_tags = {
        Environment = "PRD"
        }

}