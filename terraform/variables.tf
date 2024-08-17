variable "ansible_inventory_file_path" {
  type = string
}

variable "ansible_user" {
  type = string
}

variable "ansible_connection" {
  type = string
}

variable "key_name" {
  description = "AWS key pair to use with instances"
  type        = string
}

variable "key_path" {
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