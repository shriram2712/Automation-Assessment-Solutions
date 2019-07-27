#THE RDS instance
resource "aws_db_instance" "rds" {
  identifier ="${var.identifier}"
  allocated_storage = "${var.alloc_storage}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  name = "${var.db_name}"
  username = "${var.db_username}"
  password = "${var.db_password}"
  db_subnet_group_name = "${aws_db_subnet_group.subnet_grp.id}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
}