resource "aws_instance" "DEV-JGFTemp-WEB1" {
    ami = "ami-0f34584723e6f6fa9" # windows server 2019, DC edition
    instance_type = "t3.micro"
    subnet_id = "subnet-07f7bdc4a0ca76f9a" # dev
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    #private_ip = "10.130.1.151"
    vpc_security_group_ids = [
            "sg-05a60a2c44bd580ec" #dev alb internal
            ]
        root_block_device {
    volume_size = 100 # in GB 
    encrypted = "True"
    type = "gp3"
         }
            tags = {
            Name = "DEV-JGFTemp-WEB1"
            Environment= "DEV"
            SnapShot-Backup = "Daily-once"
            }
    volume_tags = {
        Environment = "DEV"
        Name = "DEV-JGFTemp-WEB1"
        SnapShot-Backup = "Daily-once"
        }

}