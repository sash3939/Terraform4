###cloud vars

#variable "ssh_public_key" {
#  type    = list(string)
#  default = [
#    "~/.ssh/id_rsa.pub",
#    "~/.ssh/id_ed25519.pub",
#  ]
#}


variable "ssh_public_key" {
  description = "Path to public SSH key file"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIwHD1NNsy0gdrK+rZEtC/zuop/IQ74EJt/RZn/zS9Ig ubuntu@Terraform"
}


variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "env_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "subnet_zones" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
