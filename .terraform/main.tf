terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

#========================================================
# VPC
#========================================================
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_tag_name
  }
}

resource "aws_subnet" "vpc_public_subnet" {
  vpc_id = aws_vpc.vpc.id

  cidr_block = var.vpc_subnet_cidr

  tags = {
    Name = var.vpc_subnet_tag_name
  }
}

#========================================================
# EC2
#========================================================
resource "aws_security_group" "security_group" {
    vpc_id = aws_vpc.vpc.id

    # Allow HTTP traffic from office vpn
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "http"
        cidr_blocks = ["185.18.147.159/32"]
    }

    # Allow SSH traffic from office vpn
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["185.18.147.159/32"]
    }
}

resource "aws_instance" "ec2" {
  subnet_id              = aws_subnet.vpc_public_subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]

  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance
  associate_public_ip_address = var.ec2_associate_public_ip_address

  tags = {
    Name = var.ec2_tag_name
  }
}
