
#Associating Public subnet to route table
resource "aws_route_table_association" "pub_subnet_route_table" {
  subnet_id = "${aws_subnet.pub_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}

#Associating private subnet 1 to its route table
resource "aws_route_table_association" "private_subnet1_route_table" {
  subnet_id = "${aws_subnet.prv_subnet1.id}"
  route_table_id = "${aws_route_table.private1.id}"
}

#Associating private subnet 2 to its route table
resource "aws_route_table_association" "private_subnet2_route_table" {
  subnet_id = "${aws_subnet.prv_subnet2.id}"
  route_table_id = "${aws_route_table.private2.id}"
}
