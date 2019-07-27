#SG for the situation when we require only the cidr bLOCKS
resource "aws_security_group_rule" "cb" {
  type = "${var.type}"
  description = "${var.description}"
  from_port = "${var.from_port}"
  to_port = "${var.to_port}"
  protocol = "${var.protocol}"
  security_group_id = "${var.security_group_id}"
  cidr_blocks = "${var.cidr_blocks}"

}

