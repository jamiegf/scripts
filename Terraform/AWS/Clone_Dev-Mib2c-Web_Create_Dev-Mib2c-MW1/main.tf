provider "aws" {
  region     = "eu-west-2" #London
  access_key = "AKIAUVBUS6JDAVPQ6J6T"
  secret_key = "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"
}


resource "aws_ami_from_instance" "Clone_Dev-MiB2c-WEB1" {
    name = "Clone_Dev-MiB2c-WEB1"
    source_instance_id = "i-06ee3423a8fbab943"
    tags = {
        Name = "Clone_Dev-MiB2c-WEB1"
        }

}

# add using the instance

resource "aws_instance" "DEV-MiB2C-MW1" {
    ami = aws_ami_from_instance.Clone_Dev-MiB2c-WEB1.id  #reference the above newly created AMI
    instance_type = "t3.small"
    subnet_id ="subnet-016803066ec73fa2c" # dev#####################
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-Dev"
    private_ip = "10.130.1.104"
    vpc_security_group_ids = [
        "sg-0acc79ea4bb848efb", 
        "sg-0980c9d19fe695094",
        "sg-09320fe2488b146c2"
    ]
            tags = {
            Name = "DEV-MiB2C-MW1"
            Environment= "DEV"
           # schedstarted = "true"
           # Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "DEV",
         SnapShot-Backup = "Daily-once"

        }

}

#allocate IP (
resource "aws_eip_association" "DEV-MiB2C-MW1" {
  instance_id   = aws_instance.DEV-MiB2C-MW1.id
  allocation_id = "eipalloc-080c1792ee69523fd"
}