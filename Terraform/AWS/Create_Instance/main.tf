provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDAVPQ6J6T"
  secret_key = "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"
}







resource "aws_instance" "Centos72" {
    #ami = "ami-0194c3e07668a7e36" # ubuntu
    ami = "ami-0b22fcaf3564fb0c9" # CentOS 7 (x86_64) - with Updates HVM, eu-west 2 (aka London)"
    instance_type = "t2.micro"
    subnet_id ="subnet-016803066ec73fa2c"
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.111"
            tags = {
            Name = "Centos_&_JGF2"
        }
    volume_tags = {
        Environment = "Dev"
        }


}