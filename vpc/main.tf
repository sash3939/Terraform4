terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "vpc" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "vpc_sub" {
  name           = var.env_name
  network_id     = yandex_vpc_network.vpc.id
  zone           = var.subnet_zone
  v4_cidr_blocks = var.cidr
}
