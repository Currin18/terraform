output "bucket_id" {
  description = "id of the bucket"
  value = google_storage_bucket.bucket.id
}

output "bucket_url" {
  description = "url of the bucket"
  value = google_storage_bucket.bucket.url
}