variable "subnet_zone" {
   type          = string
   default       = "ru-central1-a"
   description   = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
   validation {
     condition = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.subnet_zone)
     error_message = "Invalid zone."
   }
}

variable "env_name" {
  type        = string
  default     = "null"
  description = "VPC network&subnet name"
}

#variable "cidr" {
#  type        = list(string)
#  default     = ["10.0.1.0/24"]
#  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
#}

variable "subnets" {
   type  = list(object({ subnet_zone = string, cidr = string }))
   default = [
      {subnet_zone = "ru-central1-a", cidr = "10.0.1.0/24"}
   ]
   description   = "Зона сети"
}
