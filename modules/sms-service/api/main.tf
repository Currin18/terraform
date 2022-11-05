// template
// instance-group
// load-balancer
// healthchecks
// db (postgresql)

resource "google_compute_instance_template" "sms_api_template" {
  name_prefix  = "sms-service-template-"
  machine_type = var.machine_type
  region       = var.region


  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2204-lts"
  }

  network_interface {
    network = var.vpc
    access_config {
      // Ephemeral public IP
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
  
  tags = [ "sms-service", "api" ]

  metadata = {
    channel = "sms-service"
    mode = "api"
    env = var.env
    autogestioned = "true"
  }

  labels = {
    channel = "sms-service"
    mode = "api"
    env = var.env
    autogestioned = "true"
  }
}

resource "google_compute_http_health_check" "sms_api_health_check_http" {
  name               = "sms-service-api-health-check-http"
  request_path       = "/"
  port               = 80
  check_interval_sec = 10
  timeout_sec        = 3
}

resource "google_compute_target_pool" "sms_api_pool" {
  name = "sms-service-api-pool"

  health_checks = [google_compute_http_health_check.sms_api_health_check_http.name]
}

# resource "google_compute_health_check" "sms_api_autohealing" {
#   name                = "sms-api-autohealing-health-check"
#   check_interval_sec  = 5
#   timeout_sec         = 5
#   healthy_threshold   = 2
#   unhealthy_threshold = 10 # 50 seconds

#   http_health_check {
#     request_path = "/status"
#     port         = "443"
#   }
# }

resource "google_compute_instance_group_manager" "sms_api_instance_group" {
  name = "${var.env}-sms-service-api-group"
  base_instance_name = "${var.env}-sms-service-api-instance"
  zone = var.zone


  version {
    name = "sms-service:api"
    instance_template = google_compute_instance_template.sms_api_template.id
  }

  # all_instances_config {
  #   metadata = {
  #     channel = "sms-service"
  #     mode = "api"
  #     env = var.env
  #     autogestioned = "true"
  #   }

  #   labels = {
  #     channel = "sms-service"
  #     mode = "api"
  #     env = var.env
  #     autogestioned = "true"
  #   }
  # }

  target_pools = [google_compute_target_pool.sms_api_pool.id]

  # auto_healing_policies {
  #   health_check = google_compute_health_check.sms_api_autohealing.id
  #   initial_delay_sec = 300
  # }
}

resource "google_compute_autoscaler" "sms_api_autoscaler" {
  name = "${var.env}-sms-api-autoscaler"
  zone = var.zone
  target = google_compute_instance_group_manager.sms_api_instance_group.id

  autoscaling_policy {
    max_replicas = var.max_replicas
    min_replicas = var.min_replicas
    cooldown_period = 60

    cpu_utilization {
      target = 0.8
    }
  }
}