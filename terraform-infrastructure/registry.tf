resource "yandex_container_registry" "c-reg" {
  name = "c-registry-${terraform.workspace}"
}

resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.c-reg.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}

resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.c-reg.id
  role        = "container-registry.images.pusher"

  members = [
    "system:allUsers",
  ]
}

output "registry-id" {
  value = yandex_container_registry.c-reg.id
}