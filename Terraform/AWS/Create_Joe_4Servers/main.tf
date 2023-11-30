provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}



resource "aws_instance" "DEV-MiB2C-APP1" {
    ami = "ami-0fe82e435c7b8cd81" #centos 7 clone of dev-cloud
    instance_type = "t3.small"
    subnet_id ="subnet-016803066ec73fa2c" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.103"
            tags = {
            Name = "DEV-MiB2C-APP1"
            Environment= "Dev"
            schedstarted = "true"
            Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "Dev"
        }

}

resource "aws_instance" "STG-MiB2C-APP1" {
    ami = "ami-0fe82e435c7b8cd81" #centos 7 clone of dev-cloud
    instance_type = "t3.small"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.103"
            tags = {
            Name = "STG-MiB2C-APP1"
            Environment= "STG"
            schedstarted = "true"
            Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "STG"
        }

}




resource "aws_instance" "STG-MiB2C-WEB1" {
    ami = "ami-06f229aee4f17c1d0" #dev-1 (windows) clone
    instance_type = "t2.large"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.104"
            tags = {
            Name = "STG-MiB2C-WEB1"
            Environment= "STG"
            schedstarted = "true"
            Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "STG"
        }

}