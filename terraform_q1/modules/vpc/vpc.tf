# Creating a VPC resource and specifying the variables required"
resource "aws_vpc" "main"{
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"
  enable_dns_support = "${var.dns_support}"
  enable_dns_hostnames = "${var.dns_hostnames}"
  tags = {
    Name = "shriram-terraform-q1"
  }
}