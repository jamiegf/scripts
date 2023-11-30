resource "aws_instance" "DEV-Mipool-MARIADB1" {
    ami = "ami-0505148b3591e4c07" # , Ubuntu, 22.04 LTS
    instance_type = "t3.small" # 2cpu, 2gb 
    subnet_id = "subnet-07f7bdc4a0ca76f9a" # dev
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.10.131"
    vpc_security_group_ids = [
            "sg-08a3a51fc2f9189fb" #dev alb internal
            ]
        root_block_device {
    volume_size = 50 # in GB 
    encrypted = "true"
    volume_type = "gp3"
         }
            tags = {
            Name = "DEV-Mipool-MARIADB1"
            Environment= "DEV"
            SnapShot-Backup = "Daily-once"
            }
    volume_tags = {
        Environment = "DEV"
        Name = "DEV-Mipool-MARIADB1"
        SnapShot-Backup = "Daily-once"
        schedstarted = "true"
        Schedule = "uk-office-hours"

        }

}