#The default CIDR Block for the VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#TEnancy of the VPC -
variable "tenancy" {
  default = "default"
}

#Dns support for the vpc
variable "dns_support" {
  type = bool
  default = true
}

#DNS Hostnames for the vpc
variable "dns_hostnames" {
  type = bool
  default = true
}

#Public subnet cidr block
variable "pub_subnet_cidr" {
  default = "10.0.1.0/24"
}

#Private subnet 1 cidr block
variable "prv_subnet1_cidr" {
  default = "10.0.2.0/24"
}

#Private subnet 2 cidr block
variable "prv_subnet2_cidr" {
  default = "10.0.3.0/24"
}

#THe availability zone for the public subnet
variable "pub_subnet_az" {
  default = "us-east-1a"
}

#THe availability zone for private subnet 1
variable "prv_subnet1_az" {
  default = "us-east-1a"
}

#AZ for private subnet 2
variable "prv_subnet2_az" {
  default = "us-east-1b"
}

#Since a new Elastic IP couldnt be created due to limit reach, I had to hardcode the value for the allocation id of an available eip
variable "eip_alloc_id" {
  default = "eipalloc-0545e47907e312f33"
}

