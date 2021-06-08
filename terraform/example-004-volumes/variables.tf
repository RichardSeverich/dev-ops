variable "user_name" {
  type = string
  sensitive = true
}

variable "user_password" {
  type = string
  sensitive = true
}

variable "image" {
  default = "ubuntu-20.04-server_20210415"
  type = string
}

variable "flavor" {
  default = "server.v1_2.4R"
  type = string
}

variable "ssh_key_file" {
  default = "./../example-002/devops_rsa.pub"
  type = string
}

variable "instance_name" {
  default = "VMRISE01"
  type = string
}

variable "key_pair" {
  default = "kprise01"
  type = string
}

variable "security_group" {
  default = "sgrise01"
  type = string
}

variable "volume_name" {
  default = "vrise01"
  type = string
}
