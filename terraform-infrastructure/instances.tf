
module "kub-control" {

  source = "./modules/cheep-instance"

  instance_name = "kub-control-${terraform.workspace}"

  family="ubuntu-2004-lts"
  os_user = "ubuntu"

  cores = local.instances[terraform.workspace][0]
  memory = local.instances[terraform.workspace][1]
  core_fraction = local.instances[terraform.workspace][2]
  disk_size = local.instances[terraform.workspace][3]

  zone = "ru-central1-a"
  subnet_id = "${yandex_vpc_subnet.public-a.id}"
}

output "external_ip_kub_control" {
  value = "${module.kub-control.external-ip}"
}

module "kub-worker1" {

  source = "./modules/cheep-instance"

  instance_name = "kub-worker1-${terraform.workspace}"

  family="ubuntu-2004-lts"
  os_user = "ubuntu"

  cores = local.instances[terraform.workspace][0]
  memory = local.instances[terraform.workspace][1]
  core_fraction = local.instances[terraform.workspace][2]
  disk_size = local.instances[terraform.workspace][3]

  zone = "ru-central1-b"
  subnet_id = "${yandex_vpc_subnet.public-b.id}"
}

output "external_ip_kub_worker1" {
  value = "${module.kub-worker1.external-ip}"
}

module "kub-worker2" {

  source = "./modules/cheep-instance"

  instance_name = "kub-worker2-${terraform.workspace}"

  family="ubuntu-2004-lts"
  os_user = "ubuntu"

  cores = local.instances[terraform.workspace][0]
  memory = local.instances[terraform.workspace][1]
  core_fraction = local.instances[terraform.workspace][2]
  disk_size = local.instances[terraform.workspace][3]

  zone = "ru-central1-c"
  subnet_id = "${yandex_vpc_subnet.public-c.id}"
}

output "external_ip_kub_worker2" {
  value = "${module.kub-worker2.external-ip}"
}