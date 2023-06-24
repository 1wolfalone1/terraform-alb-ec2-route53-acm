# resource "aws_eip" "wolfalone-eip" {
#   instance = aws_instance.wolfalone.id
#   vpc      = true
# }

resource "aws_eip_association" "demo-eip-association" {
  instance_id   = aws_instance.wolfalone.id
  allocation_id = "eipalloc-0533f18f18a6eb67c"
}