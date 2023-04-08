output "backend-access-key" {
  value = yandex_iam_service_account_static_access_key.storage-account-static-key.access_key
  sensitive = true
}

output "backend-secret-key" {
  value = yandex_iam_service_account_static_access_key.storage-account-static-key.secret_key
  sensitive = true
}

