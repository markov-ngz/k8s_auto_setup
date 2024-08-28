resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "kubernetes"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-west-3a"
  cidr_block = "10.0.0.0/21" # 2048 ips
  tags = {
    Name = "kubernetes"
  }
}


resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
