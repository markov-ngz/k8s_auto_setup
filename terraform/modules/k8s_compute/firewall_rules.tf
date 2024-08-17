resource "aws_security_group" "kubernetes" {
  name        = "kubernetes"
  description = "Security Group for k8s workers and controllers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_all" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = "Allow all TLS connection to k8s cluster"
  tags = {
    Name = "allow_tls_all"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_80_all" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = "Allow all TCP connection to k8s cluster on port 80, (update package and setup)"
  tags = {
    Name = "allow_80_all"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_all_subnet" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "10.0.0.0/16"
  ip_protocol       = "all"
  to_port           = -1
  description       = "Allow all type of communication within the VPC"
  tags = {
    Name = "allow_all_subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_all" {

  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "${var.public_ip}"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow everyone to  establish an SSH connection"
  tags = {
    Name = "allow_ssh_all"
  }
}