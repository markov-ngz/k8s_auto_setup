provider "aws" {
  region = "eu-west-3"
}


resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = file("${var.key_path}")
  tags = {
    Name = var.key_name
  }
}