provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDGKEEUXWI"
  secret_key =  "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"
}


#3 create Instance from AMI (centos)

resource "aws_instance" "STG-Ansib-APP1" {
   ami = "ami-0015a39e4b7c0966f"  #ubuntu 20.04
    instance_type = "t2.small"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.106"
    vpc_security_group_ids = [
       "sg-00a2be6400569c933"   
    ] 
            tags = {
            Name = "STG-Ansib-APP1"
            Environment= "STG"

        }
    volume_tags = {
        Name = "STG-Ansib-APP1"
        Environment = "STG"
        SnapShot-Backup = "Daily-once"
        }

}