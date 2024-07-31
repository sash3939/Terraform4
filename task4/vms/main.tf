module "vpc_prod" {
  source       = "../vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "../vpc"
  env_name     = var.env_name
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}



#module "vpc_dev" {
#  source         = "../vpc"
#  env_name       = var.env_name
#  subnet_zone    = var.default_zone
#  cidr           = var.default_cidr

#}


module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing" 
  network_id     = module.vpc_dev.network_id 
  subnet_zones   = [ var.subnet_zones ]
#  subnet_ids     = [module.vpc_dev.subnet_ids]
  subnet_ids     = ["${module.vpc_prod.subnet_id}"[var.subnet_zones].id]
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
  subnet_zones   = [var.subnet_zones]
#  subnet_ids     = [module.vpc_dev.subnet_ids]
  subnet_ids     = ["${module.vpc_prod.subnet_id}"[var.subnet_zones].id]
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

