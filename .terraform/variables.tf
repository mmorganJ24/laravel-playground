variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

#========================================================
# VPC
#========================================================
variable "vpc_cidr" {
  type = string
}

variable "vpc_tag_name" {
  type = string
}

# Subnet
variable "vpc_subnet_cidr" {
  type = string
}

variable "vpc_subnet_tag_name" {
  type = string
}

#========================================================
# EC2
#========================================================
variable "ec2_tag_name" {
  type = string
}

variable "ec2_ami" {
  type = string
}

variable "ec2_instance" {
  type = string
}

variable "ec2_associate_public_ip_address" {
  type = bool
}
