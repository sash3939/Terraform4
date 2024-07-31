output "network_id" {
    description = "ID сети"
    value =  yandex_vpc_network.vpc_net.id
}


output "subnet_id" {
  value = yandex_vpc_subnet.vpc_subnet
}
