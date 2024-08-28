# 1. Security Group for all compute resources of the cluster
resource "aws_security_group" "kubernetes" {
  name        = "kubernetes"
  description = "Security Group for k8s workers and controllers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "kubernetes"
  }
}



resource "aws_vpc_security_group_ingress_rule" "allow_ssh_dev" {

  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "${var.public_ip}"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow everyone to  establish an SSH connection"
  tags = {
    Name = "allow_ssh_dev"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_kubelet_cluster" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "10.0.0.0/22"
  ip_protocol       = "tcp"
  from_port = 10250
  to_port           = 10250
  description       = "Allow kubelet"
  tags = {
    Name = "allow_kubelet_cluster"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_kubelet_cluster" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "10.0.0.0/22"
  ip_protocol       = "tcp"
  from_port = 10250
  to_port           = 10250
  description       = "Allow kubelet"
  tags = {
    Name = "allow_kubelet_cluster"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_ssh" {
  security_group_id = aws_security_group.kubernetes.id

  cidr_ipv4   = "${var.public_ip}"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# 2.2 Api server
resource "aws_vpc_security_group_ingress_rule" "allow_api_controllers" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "tcp"
  from_port         = 6443
  to_port           = 6443
  description       = "Allow 6443 ingress for kube-api-server"
  tags = {
    Name = "allow_api_all"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_api_controllers" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "tcp"
  from_port         = 6443
  to_port           = 6443
  description       = "Allow 6443 egress kube-api-server"
  tags = {
    Name = "allow_api_all"
  }
}

# 2. Controllers's Security Group

resource "aws_security_group" "kubernetes_controller" {
  name        = "kubernetes_controller"
  description = "Security Group for k8s controllers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "kubernetes_controller"
  }
}

# 2.1 Etcd 
resource "aws_vpc_security_group_ingress_rule" "allow_etcd_controllers" {
  security_group_id = aws_security_group.kubernetes_controller.id
  cidr_ipv4         = var.cidr_controllers
  ip_protocol       = "tcp"
  from_port         = 2379
  to_port           = 2380
  description       = "Allow etcd api between controllers"
  tags = {
    Name = "allow_etcd_controllers"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_etcd_controllers" {
  security_group_id = aws_security_group.kubernetes_controller.id
  cidr_ipv4         = var.cidr_controllers
  ip_protocol       = "tcp"
  from_port         = 2379
  to_port           = 2380
  description       = "Allow etcd api between controllers"
  tags = {
    Name = "allow_etcd_controllers"
  }
}


# 3. Workers's Security Group

resource "aws_security_group" "kubernetes_worker" {
  name        = "kubernetes_worker"
  description = "Security Group for k8s workers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "kubernetes_worker"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_kube-proxy" {
  security_group_id = aws_security_group.kubernetes_worker.id
  cidr_ipv4         = var.cidr_workers
  ip_protocol       = "tcp"
  from_port         = 10256
  to_port           = 10256
  description       = "Allow kube-proxy to join with the load balancers"
  tags = {
    Name = "allow_kube-proxy"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_kube-proxy" {
  security_group_id = aws_security_group.kubernetes_worker.id
  cidr_ipv4         = var.cidr_workers
  ip_protocol       = "tcp"
  from_port         = 10256
  to_port           = 10256
  description       = "Allow kube-proxy to join with the load balancers"
  tags = {
    Name = "allow_kube-proxy"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_nodeport_all" {
  security_group_id = aws_security_group.kubernetes_worker.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 30000
  to_port           = 32767
  description       = "expose nodeport services ports"
  tags = {
    Name = "allow_nodeport_all"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_nodeport_all" {
  security_group_id = aws_security_group.kubernetes_worker.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 30000
  to_port           = 32767
  description       = "expose nodeport services ports"
  tags = {
    Name = "allow_nodeport_all"
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

resource "aws_vpc_security_group_egress_rule" "allow_tcp" {
  security_group_id = aws_security_group.kubernetes.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_443_all" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = "Allow all TCP connection to k8s cluster on port 80, (update package and setup)"
  tags = {
    Name = "allow_80_all"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_433_all" {
  security_group_id = aws_security_group.kubernetes.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = "Allow all TCP connection to k8s cluster on port 80, (update package and setup)"
  tags = {
    Name = "allow_80_all"
  }
}