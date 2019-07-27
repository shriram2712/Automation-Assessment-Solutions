# Public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags ={
        Name = "Public Subnet Route Table"
    }
}
#Adding the internet gateway in the public route table routes
resource "aws_route" "public_route" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

#Private subbnet 1 route table
resource "aws_route_table" "private1" {
  vpc_id = "${aws_vpc.main.id}"

  tags ={
        Name = "Private Subnet1 Route Table"
    }
}

#Adding NAT Gateway in the private subnet
resource "aws_route" "private1" {
  route_table_id = "${aws_route_table.private1.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

#Private subnet 2 route table
resource "aws_route_table" "private2" {
  vpc_id = "${aws_vpc.main.id}"

  tags ={
        Name = "Private Subnet2 Route Table"
    }
}

#Adding routes
resource "aws_route" "private2" {
  route_table_id = "${aws_route_table.private2.id}"
  # destination_cidr_block = "0.0.0.0/0"
  # nat_gateway_id = "${aws_nat_gateway.nat.id}"
}