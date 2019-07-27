#THe input variables that are accessed by the module

#INgress/egress
variable "type" {

}

#Description of the rule
variable "description" {

}

#from port
variable "from_port" {
  type = number
}

#to port
variable "to_port" {
  type = number
}

#protocol eg:tcp, udp etc
variable "protocol" {

}

#THe security group to associate the rule with
variable "security_group_id" {

}

#The group to allow traffic for
variable "source_security_group_id" {
  
}