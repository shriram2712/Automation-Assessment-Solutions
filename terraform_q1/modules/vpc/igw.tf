#INternet Gateway for the VPC 
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "shriram-internet-gw"
  }
}