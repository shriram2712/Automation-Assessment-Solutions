#Default region for aws services
variable "default_region" {
  default = "us-east-1"
}

#port 22 ssh
variable "ssh_port" {
  type = number
  default = 22
}

#internet cidr block
variable "internet_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

#POrt for all traffic
variable "all_traffic_port" {
  type = number
  default = 0
}

#p0rt 80 http
variable "http_port" {
  type = number
  default = 80
}

#Port 443 https
variable "https_port" {
  type = number
  default = 443
}

#port 3306 mysql
variable "mysql_port" {
  type = number
  default = 3306
}

#name for subnet grp
variable "subnet_grp_name" {
  default = "Shriram-subnet-grp"
}

#name for rds instance
variable "rds_identifier" {
  default = "shriram-rds"
}

#db name
variable "db_name" {
  default = "shriram_db"
}

#db username
variable "db_username" {
  default = "shriram"
}

#db password, input from user at run time
variable "db_password" {

}

#keyname for the ec2 instances, input at run time
variable "key_name" {

}

#amazon linux ami for rds instance
variable "private_ami" {
  default = "ami-035b3c7efe6d061d5"
}
