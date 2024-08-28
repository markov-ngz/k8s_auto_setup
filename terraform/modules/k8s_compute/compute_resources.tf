resource "aws_instance" "controllers" {
  count                       = 1
  ami                         = var.ami_id
  instance_type               = "t2.medium"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.main.id
  security_groups             = [aws_security_group.kubernetes.id,aws_security_group.kubernetes_controller.id]
  associate_public_ip_address = true
  availability_zone           = "eu-west-3a"
  private_ip                  = "10.0.2.${count.index+1}"
  user_data                   = "name=controller-${count.index}"

  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "controller-${count.index}"
  }
}

resource "aws_instance" "workers" {
  count                       = 1
  ami                         = var.ami_id
  instance_type               = "t2.medium"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.main.id
  security_groups             = [aws_security_group.kubernetes.id, aws_security_group.kubernetes_worker.id]
  associate_public_ip_address = true
  private_ip                  = "10.0.1.${count.index+1}"
  user_data                   = "name=worker-${count.index}"
  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "worker-${count.index}"
  }
}