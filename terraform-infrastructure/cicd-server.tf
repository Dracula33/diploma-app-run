module "cicd" {

  source = "./modules/cheep-instance"

  instance_name = "cicd-server-${terraform.workspace}"

  family="centos-7"
  os_user = "centos"

  cores = local.instances[terraform.workspace][0]
  memory = local.instances[terraform.workspace][1]
  core_fraction = local.instances[terraform.workspace][2]
  disk_size = local.instances[terraform.workspace][3]

  zone = "ru-central1-a"
  subnet_id = "${yandex_vpc_subnet.public-a.id}"
}

output "external_ip_cicd_server" {
  value = "${module.cicd.external-ip}"
}

