resource "yandex_storage_object" "image" {
  access_key = yandex_storage_bucket.pvv-netology.access_key
  secret_key = yandex_storage_bucket.pvv-netology.secret_key
  bucket     = yandex_storage_bucket.pvv-netology.bucket
  key        = "image"
  source     = "./bucket/image.jpg"
  acl        = "public-read"
}
