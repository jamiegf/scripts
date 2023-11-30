provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}


resource "aws_ami_from_instance" "Clone_Dev-Cloud" {
    name = "Clone_Dev-Cloud"
    source_instance_id = "i-0dedf7fe99063bc73"
    tags = {
        Name = "Clone_Dev-Cloud"
        }

}

# add using the instance

resource "aws_instance" "DEV-MiB2C-APP1" {
    ami = aws_ami_from_instance.Clone_Dev-Cloud.id  #reference the above newly created AMI
    instance_type = "t3.small"
    subnet_id ="subnet-016803066ec73fa2c" # dev#####################
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.103"
    vpc_security_group_ids = [
        "sg-0762fba3326d86f11", 
        "sg-0c4eec81073e964b7"
    ]
            tags = {
            Name = "DEV-MiB2C-APP1"
            Environment= "DEV"
            schedstarted = "true"
            Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "DEV"
        }

}

#allocate IP (
resource "aws_eip_association" "DEV-MiB2C-APP1" {
  instance_id   = aws_instance.DEV-MiB2C-APP1.id
  allocation_id = "eipalloc-0d4a7884f403aa5bc"
}