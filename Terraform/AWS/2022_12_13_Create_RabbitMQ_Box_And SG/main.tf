


resource "aws_instance" "STG-SEA-RMQ1" {
    #ami = "ami-07c2ae35d31367b3e" # ubuntu 22
    ami = "ami-0beb6fc68811e5682" #ubuntu 20
        instance_type = "t2.medium"
    subnet_id ="subnet-00300816599d3f05b" # stg pub
    associate_public_ip_address = "false"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "STG-Miomni-Sports"
    private_ip = "10.81.1.20"
        vpc_security_group_ids = [
       "sg-0e8c14b320dc803ae" # dev alb internal
              ]
         root_block_device {
    volume_size = 40 # in GB 
         }
                      
            tags = {
            Name = "STG-SEA-RMQ1",
            Environment = "STG",
            SnapShot-Backup = "Daily-once"

        }
    volume_tags = {
        Name = "STG-SEA-RMQ1",
        Environment = "STG",
        SnapShot-Backup = "Daily-once"
        }


}