
# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-a"
  }
}

# Create a private subnet
resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-b"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    "Name" = "Application-1-route-table"
  }
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "game-cd"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.gw.id
}
