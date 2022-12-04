resource "yandex_compute_instance" "nat" {
  name                      = "nat"
  zone                      = "ru-central1-a"
  hostname                  = "nat.instanse.netology"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd80mrhj8fl2oe87o4e1"
      name        = "nat"
      type        = "network-nvme"
      size        = "50"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254" 
    nat       = true
  }

  metadata = {
    user-data = "${file("user.yml")}"
  }
}

resource "yandex_compute_instance" "publicInstance" {
  name                      = "public"
  zone                      = "ru-central1-a"
  hostname                  = "public.instance.netology"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd81hgrcv6lsnkremf32"
      name        = "public"
      type        = "network-nvme"
      size        = "50"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    user-data = "${file("user.yml")}"
  }
}

resource "yandex_compute_instance" "privateInstance" {
  name                      = "private"
  zone                      = "ru-central1-a"
  hostname                  = "private.instance.netology"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd81hgrcv6lsnkremf32"
      name        = "private"
      type        = "network-nvme"
      size        = "50"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    user-data = "${file("user.yml")}"
  }
}

