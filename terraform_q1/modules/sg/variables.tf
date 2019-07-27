#Name for the security group
variable "name" {

}

#Dscription for the sg
variable "description" {

}

#The VPC for the sg
variable "vpc_id" {
  
}

#Optional tags
variable "tags" {
  type = map(string)
  default = {}
}