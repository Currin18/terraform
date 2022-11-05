variable "env" {
  description = "Environment"
  type = string
}

variable "region" {
  description = "Region of GCP"
  type = string
  default = "europe-southwest1"
}

variable "zone" {
  description = "Zone of GCP"
  type = string
  default = "europe-southwest1-a"
}

variable "machine_type" {
  description = "Type of machine"
  type = string
  default = "e2-medium"
}

variable "vpc" {
  description = "VPC id"
  type = string
}

variable "max_replicas" {
  description = "Maximun replicas on instance group"
  type = number
  default = 1
}

variable "min_replicas" {
  description = "Minimun replicas on instance group"
  type = number
  default = 1
}