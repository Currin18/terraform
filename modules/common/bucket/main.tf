resource "google_storage_bucket" "bucket" {
  name = "${var.env}-${var.name}"

  location = var.location
  storage_class = var.storage_class

  # tags = var.bucket_tags

  force_destroy = var.force_destroy
  versioning {
    enabled = var.versioning_enabled
  }
}
