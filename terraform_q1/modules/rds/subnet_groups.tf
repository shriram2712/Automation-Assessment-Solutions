#Subnet groups for the rds instance
resource "aws_db_subnet_group" "subnet_grp" {
  name = "${var.subnet_grp_name}"
  subnet_ids = "${var.subnet_ids}"
  
  tags = {
    Name = "Subnet Grp for RDS"
  }
}