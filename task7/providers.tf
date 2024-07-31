terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
  cloud_id                 = "b1g0tptlsvgkbge2ul42"
  folder_id                = "b1gc36q9v49llnddjkvr"
  service_account_key_file = file("~/.key.json")
  zone                     = "ru-central1-a" 
  }

