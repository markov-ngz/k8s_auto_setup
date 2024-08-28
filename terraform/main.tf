terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 1.2.0"
}

module "k8s_compute" {

  source    = "./modules/k8s_compute"
  public_ip = var.public_ip
  ami_id    = var.ami_id
  key_name  = var.key_name
  key_path  = var.public_key_path
}

resource "local_file" "k8s_ips_yml" {

  content = yamlencode({
    controllers : {
      hosts : { for ip in module.k8s_compute.k8s_ips.controllers_ip : ip => "" }
    }
    workers : {
      hosts : { for ip in module.k8s_compute.k8s_ips.workers_ip : ip => "" }
    }
    all : {
      vars : {
        ansible_user : var.ansible_user
        ansible_connection : var.ansible_connection
      }
    }
  })
  filename = var.ansible_inventory_file_path
}