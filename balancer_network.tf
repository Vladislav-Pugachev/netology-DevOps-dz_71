resource "yandex_lb_network_load_balancer" "nlb" {
  name = "nlb"
  listener {
    name = "netology"
    port = 8000
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.lampgroup.load_balancer[0].target_group_id
    healthcheck {
      name = "web"
        http_options {
          port = 80
          path = "/"
        }
    }
  }
}