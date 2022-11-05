locals {
  env        = "dev"
  gcp_region = "europe-southwest1"
  gcp_zone   = "europe-southwest1-a"
  service_file = "./files/gcp-terraform-service.json"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.42.0"
    }
  }
}

provider "google" {
  credentials = file(local.service_file)

  project = "terraform-and-ansible-deploy"
  region  = local.gcp_region
  zone    = local.gcp_zone
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

module "bucket_tfstate" {
  source = "../../modules/common/bucket"
  env = local.env
  name = "${random_id.bucket_prefix.hex}-bucket-tfstate"
}

module "vpc" {
  source   = "../../modules/common/vpc"
  vpc_name = "dev"
}