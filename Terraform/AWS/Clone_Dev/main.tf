provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}


resource "aws_ami_from_instance" "J-Test-AMI" {
    name = "Clone-RMQ1"
    source_instance_id = " i-0426ca1b89f9e275d"
    tags = {
        Name = "Clone_of_RabbitMQ1-STG"
        }

}

# add using the instance

resource "aws_instance" "RabbitMQ-3" {
    ami = aws_ami_from_instance.J-Test-AMI.id  #reference the above newly created AMI
    instance_type = "t2.micro"
    subnet_id ="subnet-0fb419c5b9fe776f1" # stg
    associate_public_ip_address = "true"
    disable_api_termination = "true"
    iam_instance_profile = "Miomni-Sys-Man-Role"
    key_name = "Miomni-STG"
    private_ip = "10.140.1.105"
            tags = {
            Name = "RabbitMQ3"
            Environment= "STG"
            schedstarted = "true"
            Schedule = "uk-office-hours"
        }
    volume_tags = {
        Environment = "STG"
        }

}