
resource "yandex_iam_service_account" "storage-account" {
  name      = "storage-account"
}

resource "yandex_resourcemanager_folder_iam_member" "storage-editor" {
  folder_id = var.folder_id
#  role      = "storage.editor"
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.storage-account.id}"
}

resource "yandex_iam_service_account_static_access_key" "storage-account-static-key" {
  service_account_id = yandex_iam_service_account.storage-account.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "tf-state-bckt" {
  access_key = yandex_iam_service_account_static_access_key.storage-account-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage-account-static-key.secret_key
  bucket = "tf-state-bckt"
  max_size = 1073741824
  default_storage_class = "STANDARD"
  force_destroy = true
}
