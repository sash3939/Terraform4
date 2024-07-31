resource "vault_generic_secret" "my_first_secret" {
  path = "secret/create"

  data_json = <<EOT
{
  "Netology":   "SecretKey!"
}
EOT
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}



data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

data "vault_generic_secret" "my_first_secret" {
  path = "secret/create"
}


output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

output "my_first_secret" {
  value = nonsensitive(data.vault_generic_secret.my_first_secret.data)
}
