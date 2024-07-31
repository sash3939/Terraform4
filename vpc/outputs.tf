output "network_id" {
    value = yandex_vpc_network.vpc.id
}

output "subnet_ids" {
    value = yandex_vpc_subnet.vpc_sub.id
}

output "subnet_zones" {
    value = yandex_vpc_subnet.vpc_sub.zone
}
