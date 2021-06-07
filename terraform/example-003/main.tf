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
# Create Key Pair
resource "openstack_compute_keypair_v2" "key_pair" {
  name = "${var.key_pair}"
  public_key = file("${var.ssh_key_file}")
}
# Create Security Group
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name = "${var.security_group}"
  description = "Richard security group"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 3389
    to_port = 3389
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }
}
# Create server
resource "openstack_compute_instance_v2" "dev_server" {
  count           = var.instance_count
  name            = "${var.instance_prefix}0${(count.index+1)}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = openstack_compute_keypair_v2.key_pair.name
  security_groups = ["default", "${openstack_compute_secgroup_v2.secgroup_1.name}"]
}
