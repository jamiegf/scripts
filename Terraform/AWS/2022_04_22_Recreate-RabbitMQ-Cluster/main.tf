
provider "aws" {
   region = "us-west-1"
	 access_key = "AKIAUVBUS6JDGKEEUXWI"
  secret_key =  "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"
 } 
 
 


#create EC2 instance


resource "aws_instance" "PRD-RabbitMQ-1" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.small"  #1 core, 2GB ram
    subnet_id ="subnet-0b28fd222a9192777" # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.1.21"
        vpc_security_group_ids = [
       "sg-00dea691f329a8bfa",
       "sg-01fe6b93e3e69002c",
       "sg-0fd0c12c493610e69"
    
        ]
         root_block_device {
    volume_size = 40 # in GB 
         }
            tags = {
            Name = "PRD-RabbitMQ-1"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-RabbitMQ-1",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}

resource "aws_instance" "PRD-RabbitMQ-2" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.small"  #1 core, 2GB ram
    subnet_id = "subnet-05688f8c2300703b8" # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.2.21"
        vpc_security_group_ids = [
       "sg-00dea691f329a8bfa",
       "sg-01fe6b93e3e69002c",
       "sg-0fd0c12c493610e69"
    
        ]
         root_block_device {
    volume_size = 40 # in GB 
         }
            tags = {
            Name = "PRD-RabbitMQ-2"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-RabbitMQ-2",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}


resource "aws_instance" "PRD-RabbitMQ-3" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.small"  #1 core, 2GB ram
    subnet_id = "subnet-09c63c3c099e85b40" # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.190.5.21"
         vpc_security_group_ids = [
       "sg-00dea691f329a8bfa",
       "sg-01fe6b93e3e69002c",
       "sg-0fd0c12c493610e69"
    
        ]
         root_block_device {
    volume_size = 40 # in GB 
         }
            tags = {
            Name = "PRD-RabbitMQ-3"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-RabbitMQ-3",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}

#allocate IP 
resource "aws_eip_association" "PRD-RabbitMQ-1" {
  instance_id   = aws_instance.PRD-RabbitMQ-1.id
  allocation_id = "eipalloc-09cc450d1429cd440"
}

resource "aws_eip_association" "PRD-RabbitMQ-2" {
  instance_id   = aws_instance.PRD-RabbitMQ-2.id
  allocation_id = "eipalloc-02b1bba23577a4611"
}

