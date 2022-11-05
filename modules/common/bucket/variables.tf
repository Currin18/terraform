variable "env" {
  description = "Name of the Storage bucket. Must be unique"
  type = string
  default = "default"
}

variable "name" {
  description = "Name of the Storage bucket. Must be unique"
  type = string
  default = "storage"
}

variable "location" {
  description = "Location of the Storage bucket"
  type = string
  default = "EU"
}

variable "storage_class" {
  description = "The Storage Class of the bucket"
  type = string
  default = "STANDARD"
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  type = bool
  default = false
}

variable "versioning_enabled" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type = bool
  default = true
}