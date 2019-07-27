#THe variables output here are accessed in the dev/main.tf while impoerting the modules and building resources dependent on them


output "security_group_id" {
  value = "${aws_security_group.sg.id}"
}