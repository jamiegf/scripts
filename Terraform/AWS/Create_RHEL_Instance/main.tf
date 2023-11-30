provider "aws" {
  region     = "eu-west-2" #London
  access_key = "*************"
  secret_key = "wiFssYOlTfN0P8YmyPh/xBQribvKfM/Z68Cu7y+N"
}




resource "aws_instance" "STG-SEA-ICASINO1" {
    #ami = "ami-0194c3e07668a7e36" # ubuntu
    ami = "ami-035c5dc086849b5de" # RHEL
    instance_type = "t3.medium"
    subnet_id ="subnet-044821a03053a2bac" #stg-miomni-private
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.10.121"
        #vpc_security_group_ids = [
       #"sg-0d351db1e9ba7a33e"
              #]
         root_block_device {
    volume_size = 100 # in GB 
         }
                      
            tags = {
            Name = "STG-SEA-ICASINO1",
            Environment = "STG",
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }


}