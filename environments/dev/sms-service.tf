# sms-service:api
module "sms-service-api" {
  source = "../../modules/sms-service/api"

  env    = local.env
  region = local.gcp_region
  zone   = local.gcp_zone
  # machine_type = "e2-medium"
  vpc = module.vpc.vpc_id
  # max_replicas = 1
  # min_replicas = 1
}