# create security group
resource "aws_security_group" "allow_jamiegf" {
  name        = "allow_jamiegf"
  description = "Allow jamiegf SSH inbound traffic"
  vpc_id      = aws_vpc.WEB.id

  ingress {
    description      = "SSH from Jamiegf"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["81.174.157.230/32"] #[aws_vpc.WEB.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_jamiegf"
  }
}



#create EC2 instance


resource "aws_instance" "PRD-APK-WEB1" {
    ami = "ami-01f87c43e618bf8f0" #Ubuntu Server 20.4LTS BAse IMage
    instance_type = "t2.medium"  #2 cores, 4GB ram
    subnet_id =aws_subnet.WEB-1.id # PRD
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Shore-Traders-Prod"
    private_ip = "10.191.1.11"
        vpc_security_group_ids = [
        aws_security_group.allow_jamiegf.id #jamiegf home rdp created above
        
        ]
         root_block_device {
    volume_size = 80 # in GB 
         }
            tags = {
            Name = "PRD-APK-WEB1"
            Environment= "PRD"
         
        }
    volume_tags = {
        Name = "PRD-APK-WEB1",
        Environment = "PRD",
        SnapShot-Backup = "Daily-once"
        }

}