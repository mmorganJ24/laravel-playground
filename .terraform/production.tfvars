aws_access_key = "XXX"
aws_secret_key = "XXX"

#========================================================
# VPC
#========================================================
# CIDR block notes:
# IP addresses are 32 bits in length with 8 bits per section -> 8(0-255).8(0-255).8(0-255).8(0-255)
# The max int of a section is 255 and the /* of a CIDR block is a subset selector.
# Notice in the below examples the *.1.* are meaning the examples would be nested subnets within one another.
#
# Examples:
# 10.0.0.0/16 -> 16 network bits & 16 host bits -> 2^16 -> 65,536 possible hosts -> 10.0.*.*
# 10.0.1.0/24 -> 24 network bits & 8 host bits -> 2^8 -> 256 possible hosts -> 10.0.1.*
# 10.0.1.1/32 -> 32 network bits & 0 host bits -> 2^0 -> 1 possible host -> 10.0.1.1

vpc_tag_name = "production-vpc"
vpc_cidr     = "10.0.0.0/16" # 65,536 IP addresses

vpc_subnet_tag_name = "production-vpc-subnet"
vpc_subnet_cidr     = "10.0.1.0/24" # 256 IP addresses

#========================================================
# EC2
#========================================================
ec2_tag_name                    = "production-ec2"
ec2_ami                         = "ami-06e46074ae430fba6"
ec2_instance                    = "t2.nano"
ec2_associate_public_ip_address = true
