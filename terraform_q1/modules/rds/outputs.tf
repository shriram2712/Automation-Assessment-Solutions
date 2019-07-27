#THe variables output here are accessed in the dev/main.tf while impoerting the modules and building resources dependent on them


output "rds_endpoint" {
  value = "${aws_db_instance.rds.endpoint}"
}