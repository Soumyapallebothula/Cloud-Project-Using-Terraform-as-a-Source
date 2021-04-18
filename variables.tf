variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "vpc_tenancy"{
  default = "default"
}
variable "subnet_cidr" {
  default = "192.168.1.0/24"
}
variable "priv_cidr"{
  default = "192.168.50.0/24"
}
variable "web_ami"{
  default = "ami-047a51fa27710816e"
}
variable "instn_type"{
  default = "t2.micro"
}
variable "subnet1_cidr" {
  default = "192.168.20.0/24"
}
variable "subnet2_cidr" {
  default = "192.168.30.0/24"
}
