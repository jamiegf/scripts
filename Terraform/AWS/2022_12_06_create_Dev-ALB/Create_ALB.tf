#this script lacks creating a global accelerator, attaching security groups to instances, adding the internal-alb SG rule to accept http from the external alb sg
#register target instances to the target groups

#create ALB-External Security Group

resource "aws_security_group" "alb" { 
  name        = "DEV-Miomni-ALB-External" #update
  description = "Allow external http and https traffic to ALB"
  vpc_id      = "vpc-0138d458294c2378d" # get vpc id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DEV-Miomni-ALB-External" #update 
  }
}



#create ALB-Internal Security Group

resource "aws_security_group" "albinternal" { 
  name        = "DEV-Miomni-ALB-Internal" #update
  description = "Allow external http and https traffic to ALB"
  vpc_id      = "vpc-0138d458294c2378d" # get vpc id



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #ingress = ["${aws_security_group.alb.id}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DEV-Miomni-ALB-Internal" #update 
  }
}

######################
#create ALB

resource "aws_alb" "alb" {
  name            = "DEV-Miomni-ALB" #update
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["subnet-0da4e7d4af9b4d9f0","subnet-007208197fc78e2a0" ] # update
  tags = {
    Name = "DEV-Miomni-ALB"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "DEV-BG-WEB"  #update
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0138d458294c2378d" #update
  stickiness {
    type = "lb_cookie" # update
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

#####
#create listeners

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
        type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#####

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:311747045935:certificate/d2244ee2-fcd9-4ef2-ac8f-c539b743373c" #miomni.com
  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}

