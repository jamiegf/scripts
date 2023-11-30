provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDD2AKIBH4"
  secret_key = "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"
}




resource "aws_instance" "Dev-Mipool-APP1" {
    ami = "ami-07c2ae35d31367b3e" # ubuntu
    instance_type = "t3.medium"
    subnet_id ="subnet-07f7bdc4a0ca76f9a" # dev mipools private
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.10.111"
            tags = {
            Name = "DEV-Mipool-APP1"
            Environment= "DEV"
            SnapShot-Backup = "Daily-once"
        }
    volume_tags = {
        Name = "DEV-Mipool-APP1"
        Environment = "DEV"
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "Dev-Mipool-MariaDB" {
    ami = "ami-07c2ae35d31367b3e" #ubuntu
    instance_type = "t3.medium"
    subnet_id ="subnet-07f7bdc4a0ca76f9a" # dev mipools private
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.10.112"
            tags = {
            Name = "Dev-Mipool-MariaDB"
            Environment= "DEV"
            SnapShot-Backup = "Daily-once"
        }
    volume_tags = {
        Name = "Dev-Mipool-MariaDB"
        Environment = "DEV"
        SnapShot-Backup = "Daily-once"
        }

}