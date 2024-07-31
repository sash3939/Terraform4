terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}


provider "yandex" {
  service_account_key_file = file("~/.key.json")
  zone = "ru-central1-a" #(Optional)
  folder_id = "b1gc36q9v49llnddjkvr"
}
