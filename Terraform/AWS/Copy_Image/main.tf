provider "aws" {
  region     = "eu-west-2" #London
  access_key = "******************"
  secret_key = "3xxbJE8StNutHQ5S6CDxT4WTpqa1JkJAhOmpPejf"
}

resource "aws_ami_copy" "clone_of_Dev-Cloud" {
  name              = "clone_Dev-Cloud"
  description       = "A copy of Dev-Cloud centos 7 server"
  source_ami_id     = "ami-07348ae95ffb9d617"
  source_ami_region = "eu-west-2"

  tags = {
    Name = "Dev-Cloud-Clone"
  }
}

resource "aws_ami_copy" "clone_of_Dev-1" {
  name              = "clone_Dev-1"
  description       = "A copy of Dev-Cloud centos 7 server"
  source_ami_id     = "ami-07fbc235a336ee150"
  source_ami_region = "eu-west-2"

  tags = {
    Name = "Dev-1-Clone"
  }
}



