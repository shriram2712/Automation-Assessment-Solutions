
#SEcurity group rules for a situation where we require only security group id and not cidr block
resource "aws_security_group_rule" "sg" {
  type = "${var.type}"
  description = "${var.description}"
  from_port = "${var.from_port}"
  to_port = "${var.to_port}"
  protocol = "${var.protocol}"
  security_group_id = "${var.security_group_id}"
  source_security_group_id = "${var.source_security_group_id}"

}