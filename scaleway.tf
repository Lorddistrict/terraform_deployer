terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone        = "fr-par-1"
  region      = "fr-par"
  access_key  = var.access_key
  secret_key  = var.secret_key
  project_id  = var.project_id
}

resource "scaleway_instance_ip" "public_ip" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "web" {
  project_id  = var.project_id
  type        = "DEV1-S"
  image       = "debian_bullseye"
  tags        = ["front", "web"]
  ip_id       = scaleway_instance_ip.public_ip.id

  root_volume {
    size_in_gb = 20
  }

  connection {
    type     = "ssh"
    user     = var.server_user
    password = var.server_password
    host     = scaleway_instance_server.web.public_ip
  }

  provisioner "file" {
    source = "./ansible/playbook.yaml"
    destination = "/home/debian/playbook.yaml"
  }

  provisioner "file" {
    source = "./ansible/variables.yaml"
    destination = "/home/debian/variables.yaml"
  }

  provisioner "file" {
    source = "./ansible/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/install.sh",
      "/tmp/install.sh",
    ]
  }
}
