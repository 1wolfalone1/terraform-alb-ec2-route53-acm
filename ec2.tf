
resource "aws_key_pair" "game-cd" {
  key_name   = "game-cd"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "game-cd"
}

resource "aws_instance" "wolfalone" {
  ami             = var.ami_ubuntu
  instance_type   = var.size_instance
  key_name        = "game-cd-v2"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  subnet_id       = aws_subnet.public-a.id
  tags = {
    Name = "wolfalone"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.wolfalone.public_ip
    port        = 22
    private_key = tls_private_key.rsa.private_key_pem
  }
  user_data = file("user-data/user_data.tpl")
}

