#THe default ami of the amazon linux in us-east-2
variable "ami" {
  default = "ami-026c8acd92718196b"
}

#the instance type
variable "instance_type" {
  default = "t2.micro"
}

#for public ip
variable "associate_public_ip_address" {
  type = bool
  default = true
}

#the subnet to host the ec2 instance in
variable "subnet_id" {

}

#the security groups for the ec2 instance
variable "vpc_security_group_ids" {
  type = list(string)
}

#the ssh keypair file- has to be present with the user
variable "key_name" {

}

#the user data that has anything to be run at launch time
variable "user_data" {
  default = <<EOF
  EOF
}

#optional tags
variable "tags" {
  type = map(string)
  default = {}
}