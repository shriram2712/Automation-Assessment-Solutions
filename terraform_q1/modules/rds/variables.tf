#Name for the subnet group
variable "subnet_grp_name" {

}

#IDS of the subnets in the subnet group
variable "subnet_ids" {
  type = list(string)
}

#Identifier for the rds instance
variable "identifier" {

}

#ALLOCATED STORAGE
variable "alloc_storage" {
  type = number
  default = 20
}

#Engine version of the database-server
variable "engine_version" {
  default = "5.7.22"
}

#Database server
variable "engine" {
  default = "mysql"
}

#DB instance class
variable "instance_class" {
  default = "db.t2.micro"
}

#db name
variable "db_name" {

}

#database username
variable "db_username" {

}

#database password
variable db_password {

}

#the security groups for the rds instance 
variable vpc_security_group_ids {
  type = list(string)
}