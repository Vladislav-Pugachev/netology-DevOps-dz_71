resource "yandex_compute_instance_group" "lampgroup" {
  name                = "lamp"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.sa.id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 3
      }
    }
    network_interface {
      network_id = yandex_vpc_network.network_netology.id
      subnet_ids = [yandex_vpc_subnet.public.id]
    }
    labels = {
      label = "lamp"
    }
    metadata = {
        user-data = "${file("html.yml")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 1
    max_expansion   = 2
    max_deleting    = 3
  }
  load_balancer {
    target_group_name        = "web-group"
    target_group_description = "load balancer web group"
  }
  health_check {
    interval = 2
    timeout = 1
    healthy_threshold = 2
    unhealthy_threshold = 2
    http_options {
      path = "/"
      port = 80
    }
  }
}