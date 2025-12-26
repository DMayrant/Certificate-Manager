resource "aws_lb" "ALB" {
  name               = "public-subnet-alb-${var.env}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.app_sg.id]
  subnets         = aws_subnet.public_subnet[*].id

  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = "Public-ALB"
  })
}


# Create a target group and Health checks for the ALB
resource "aws_lb_target_group" "alb_tg" {
  name        = "instance-tg-${var.env}" # FIX: Environment-specific name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.common_tags, {
    Name = "ALB-TG-${var.env}"
  })
}

#### A AWS ACM IS NEEDED FOR HTTPS LISTENER ON PORT 443 ####

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.app_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

#### HTTP ON PORT 80 WITHOUT ACM ####

#resource "aws_lb_listener" "http_listener" {
#load_balancer_arn = aws_lb.ALB.arn
#port              = 80
#protocol          = "HTTP"

#default_action {
#type             = "forward"
#target_group_arn = aws_lb_target_group.alb_tg.arn
#}
#}




  