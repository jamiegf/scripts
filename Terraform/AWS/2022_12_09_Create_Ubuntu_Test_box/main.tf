
resource "aws_instance" "JGF-Test" {
    ami = "ami-07c2ae35d31367b3e" # ubuntu 22
    #ami = "ami-0beb6fc68811e5682" #ubuntu 20
    #ami = "ami-04706e771f950937f" # wordpress 
    instance_type = "t2.micro"
    subnet_id ="subnet-007208197fc78e2a0"
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Dev-MiomniSports"
    #private_ip = "10.130.10.101"
        vpc_security_group_ids = [
       "sg-0d7535a550535c75c" # dev alb internal
              ]
         root_block_device {
    volume_size = 20 # in GB 
         }
                      
            tags = {
            Name = "JGF-Test",
            Environment = "Dev",
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "JGF-Test",
        Environment = "Dev",
        SnapShot-Backup = "Daily-once"
        }


}