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

variable "cidr_controllers" {
  description = "cidr used by the controllers"
  type = string
  default = "10.0.2.0/24"
}
variable "cidr_workers" {
  description = "cidr used by the workers"
  type = string
  default = "10.0.1.0/24"
}