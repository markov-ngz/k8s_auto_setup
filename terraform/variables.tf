variable "ansible_inventory_file_path" {
  type = string
  description = "Relative path to the ansible inventory folder to write the inventory "
}

variable "ansible_user" {
  type = string
  default = "ubuntu"
  description = "default user to connect to AWS instance"
}

variable "ansible_connection" {
  type = string
  default = "ssh"
  description = "type of connection used by ansible to connect the remote instances"
}

variable "key_name" {
  description = "AWS key pair to use with instances"
  type        = string
}

variable "public_key_path" {
  description = "file path to kubernetes private key for ssh"
  type        = string
  sensitive   = true
}
variable "ami_id" {
  description = "Ubuntu 22.04 ami"
  type        = string
}

variable "public_ip" {
  description = "public IP to restrict ssh or TCP connexion to my computer"
  type        = string
  sensitive   = true
}