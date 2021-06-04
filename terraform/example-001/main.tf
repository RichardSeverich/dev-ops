# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.41.0"
    }
  }
}
# Configure the OpenStack Provider
provider "openstack" {
  user_domain_name = "jalasoft"
  user_name   = var.user_name
  password    = var.user_password
  auth_url    = "https://10.24.1.230:5000/v3"
  tenant_id   = "ec2e02a3c58b4a689fe62be31b3f4a87"
  insecure    = true
  region      = "jala-hq"
}
# Create a dev server
resource "openstack_compute_instance_v2" "dev_server" {
  name            = "VMRISE01"
  image_name      = "ubuntu-20.04-server_20210415"
  flavor_name     = "server.v1_2.4R"
  key_pair        = "devops_id_rsa"
}
# Variables
variable "user_name" {
  type = string
  sensitive = true
}
variable "user_password" {
  type = string
  sensitive = true
}
