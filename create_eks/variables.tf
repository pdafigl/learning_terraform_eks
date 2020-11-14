# Variables for provider

variable "region" {
  type = string
}

variable "project_name" {
  type = string
}
# Variables to create VPC

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}


variable "private_subnets" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]

}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

# Variables to create security group
variable "name_prefix" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}