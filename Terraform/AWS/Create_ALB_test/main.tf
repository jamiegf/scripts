#create ALB-Internal Security Group

resource "aws_security_group" "albinternal" { 
  name        = "PRD-Miomni-ALB-Internal" #update
  description = "Allow external http and https traffic to ALB"
  vpc_id      = "vpc-0e880266fe719c66f" # get vpc id



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    aws_security_group = ["${aws_security_group.alb.id}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PRD-ALB-Internal" #update 
  }
}