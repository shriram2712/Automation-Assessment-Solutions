#THe variables output here are accessed in the dev/main.tf while impoerting the modules and building resources dependent on them

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "private_subnet1_id" {
  value = "${aws_subnet.prv_subnet2.id}"
}

output "private_subnet2_id" {
  value = "${aws_subnet.prv_subnet2.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.pub_subnet.id}"
}