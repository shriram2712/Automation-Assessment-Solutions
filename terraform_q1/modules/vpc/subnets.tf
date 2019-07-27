#The public subnet for the public ec2 instance
resource "aws_subnet" "pub_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.pub_subnet_cidr}"
  availability_zone = "${var.pub_subnet_az}"
  tags = {
    Name = "shriram-public-subnet" 
  }
}

#THe private subnet for the private ec2 instance
resource "aws_subnet" "prv_subnet1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.prv_subnet1_cidr}"
  availability_zone = "${var.prv_subnet1_az}"
  tags = {
    Name = "shriram-private-subnet1" 
  }
}

#Private subnet for the private rds instance
resource "aws_subnet" "prv_subnet2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.prv_subnet2_cidr}"
  availability_zone = "${var.prv_subnet2_az}"
  tags = {
    Name = "shriram-private-subnet2" 
  }
}

