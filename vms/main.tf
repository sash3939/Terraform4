#создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

#создаем подсеть
#resource "yandex_vpc_subnet" "develop_a" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}

#resource "yandex_vpc_subnet" "develop_b" {
#  name           = "develop-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.2.0/24"]
#}

module "vpc_dev" {
  source         = "../vpc"
  env_name       = var.env_name
  subnet_zone    = var.default_zone
  cidr           = var.default_cidr

}


module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing" 
  network_id     = module.vpc_dev.network_id 
 # network_id     = yandex_vpc_network.develop.id
  subnet_zones   = [ module.vpc_dev.subnet_zones ]
  subnet_ids     = [module.vpc_dev.subnet_ids]
#  subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "a.egorkin",
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
   # user-data = "${file("./cloud-init.yml")}"
   # ssh-keys           = "ubuntu:${file("/home/ubuntu/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet_ids]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true


  labels = {
    owner= "a.egorkin",
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
   # ssh-keys           = "ubuntu:${file("/home/ubuntu/.ssh/id_ed25519.pub")}"
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_public_key = "${file("/home/ubuntu/.ssh/id_ed25519.pub")}"
#    ssh_public_key = "ubuntu:${file("/home/ubuntu/.ssh/id_ed25519.pub")}"
  }
}

