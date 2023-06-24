resource "aws_acm_certificate" "acm_game_cd" {
  domain_name       = "game-cd.1wolfalone1.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
