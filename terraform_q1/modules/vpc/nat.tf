
#NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = "${var.eip_alloc_id}"
  subnet_id = "${aws_subnet.pub_subnet.id}"
  tags = {
    Name = "Shriram NAT gateway"
  }
}