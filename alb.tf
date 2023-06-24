
resource "aws_lb_target_group" "my-tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
}



resource "aws_lb_target_group_attachment" "attach-game-cd" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.wolfalone.id
  port = 80
}

resource "aws_lb" "game_cd" {
  name               = "gameCd"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.public-a.id, aws_subnet.public-b.id]

  tags = {
    Name = "gameCd"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.game_cd.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "my-listener" {
  load_balancer_arn = aws_lb.game_cd.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.acm_game_cd.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
}

