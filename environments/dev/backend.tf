terraform {
  backend "gcs" {
    bucket  = "dev-7d997d72909c0c0a-bucket-tfstate"
    prefix  = "terraform/state"
  }
}