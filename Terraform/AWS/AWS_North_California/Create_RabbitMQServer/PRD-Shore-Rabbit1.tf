provider "aws" {
  region     = "us-west-1" #North California
  access_key = "AKIAUVBUS6JDAVPQ6J6T"
  secret_key = "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"
}


resource "aws_instance" "PRD-TRADER-RMQ1" {
    ami = "ami-0d382e80be7ffdae5"  #Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    instance_type = "t2.large"
    subnet_id ="subnet-05688f8c2300703b8" #
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.2.11"
            tags = {
            Name = "PRD-TRADER-RMQ1"
            Environment = "PRD"

        }
    volume_tags = {
        Environment = "PRD"
        }

}