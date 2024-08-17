resource "aws_instance" "controllers" {
  count                       = 2
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.main.id
  security_groups             = [aws_security_group.kubernetes.id]
  associate_public_ip_address = true
  availability_zone           = "eu-west-3a"
  private_ip                  = "10.0.1.1${count.index}"
  user_data                   = "name=controller-${count.index}"

  root_block_device {
    volume_size = 8
  }
  tags = {
    Name = "controller-${count.index}"
  }
}

# resource "aws_instance" "workers" {
#   count                       = 1
#   ami                         = var.ami_id
#   instance_type               = "t2.medium"
#   key_name                    = var.key_name
#   subnet_id                   = aws_subnet.main.id
#   security_groups             = [aws_security_group.kubernetes.id]
#   associate_public_ip_address = true
#   private_ip                  = "10.0.1.2${count.index}"
#   user_data                   = "name=worker-${count.index}"
#   root_block_device {
#     volume_size = 12
#   }
#   tags = {
#     Name = "worker-${count.index}"
#   }
# }