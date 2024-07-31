terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "simple-bucket-wuys0f7r"
    region = "ru-central1"
    key    = "vpc/terraform.tfstate"
    access_key = "YCAJEFvdHG9ncknBVA2jff2Vh"
    secret_key = "YCNsJUW0lGrCfKSpAqQtxqEVsoLPyUpNZU2zQf9n"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
output "subnet_id" {
  value = yandex_vpc_subnet.develop.id
}
