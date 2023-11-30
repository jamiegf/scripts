#this script lacks creating a global accelerator, attaching security groups to instances, adding the internal-alb SG rule to accept http from the external alb sg
#regioster target instances to the target groups

#create ALB-External Security Group

resource "aws_security_group" "alb" { 
  name        = "PRD-Miomni-ALB-External" #update
  description = "Allow external http and https traffic to ALB"
  vpc_id      = "vpc-0e880266fe719c66f" # get vpc id

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
    Name = "PRD-Miomni-ALB-External" #update 
  }
}



#create ALB-Internal Security Group

resource "aws_security_group" "albinternal" { 
  name        = "PRD-Miomni-ALB-Internal" #update
  description = "Allow external http and https traffic to ALB"
  vpc_id      = "vpc-0e880266fe719c66f" # get vpc id



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
    Name = "PRD-Miomni-ALB-Internal" #update 
  }
}

######################
#create ALB

resource "aws_alb" "alb" {
  name            = "PRD-Miomni-ALB" #update
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["subnet-03fe6f5d4e6828f79","subnet-0aefa03b647e6bb3d" ] # update
  tags = {
    Name = "PRD-Miomni-ALB"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "PRD-Miomni-WEB2"  #update
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0e880266fe719c66f" #update
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

