#Clone_Copy_Dev-Mib2c-web_to_PRD-Mib2C-WEB1


provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDAVPQ6J6T"
  secret_key = "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"
}


resource "aws_ami_from_instance" "Clone_DEV-MiB2C-WEB1" {
    name = "Clone_DEV-MiB2C-WEB1"
    source_instance_id = "i-06ee3423a8fbab943"
    tags = {
        Name = "Clone_DEV-MiB2C-WEB1"
        }

}

# add using the instance

resource "aws_instance" "PRD-MiPool-WEB1" {
    ami = aws_ami_from_instance.Clone_DEV-MiB2C-WEB1.id  #reference the above newly created AMI
    instance_type = "t3.large"
    subnet_id ="subnet-07dd807442f2f5bce" ######## PRD  #####################
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Prod"
    private_ip = "10.160.1.111"
    vpc_security_group_ids = [
        "sg-09ac81bb22bbf9606", 
        "sg-00134d79da7f39cf7"
    ]
            tags = {
            Name = "PRD-MiPool-WEB1"
            Environment= "PRD"
            #schedstarted = "true"
           # Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "PRD"
        }

}

#allocate IP (
resource "aws_eip_association" "PRD-Mipool-WEB1-IP" {
  instance_id   = aws_instance.PRD-MiPool-WEB1.id
  allocation_id = "eipalloc-010261f7bf5b6d29e"
}