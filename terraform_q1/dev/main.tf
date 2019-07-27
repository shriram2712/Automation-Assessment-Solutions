#SEtting the provider, will take the default configurations set
provider "aws" {
  profile    = "default"
  region     = "${var.default_region}"
}

#Importing and creating the vpc and all associated resources from the module
module "my_vpc" {
  source = "../modules/vpc"
}

#THe security group for the public instance
module "pub_ec2_sg" {
  source  = "../modules/sg"
  name = "Public_EC2_SG"
  description = "Security group for the public ec2 instance, allows all access"
  vpc_id = "${module.my_vpc.vpc_id}"
  tags = {
    Name = "Public_EC2_SG"
  }
}

#Ingress pub inst all SSH from all IP
module "pub_ec2_sg_ingress" {
  source = "../modules/sg_rules_cidr"

  type = "ingress"
  description = "Allows Inbound SSH access to all IP, rest are restricted"
  from_port = "${var.ssh_port}"
  to_port = "${var.ssh_port}"
  protocol = "tcp"
  security_group_id = "${module.pub_ec2_sg.security_group_id}"
  cidr_blocks = "${var.internet_cidr_blocks}"
}

#Egress pub inst outbound all traffic 
module "pub_ec2_sg_egress" {
  source = "../modules/sg_rules_cidr"
  
  type = "egress"
  description = "Allows outbound access to all IP"
  from_port = "${var.all_traffic_port}"
  to_port = "${var.all_traffic_port}"
  protocol = "-1"
  security_group_id = "${module.pub_ec2_sg.security_group_id}"
  cidr_blocks = "${var.internet_cidr_blocks}"
}

#Private ec2 instance sg
module "prv_ec2_sg" {
  source = "../modules/sg"
  name = "Private_EC2_SG"
  description = "Security group for the private ec2 instance, allows SSH access inbound from the public ec2 instance, http, https outbound for internet access, and mysql outbound to access rds"
  vpc_id = "${module.my_vpc.vpc_id}"
  tags = {
    Name = "Private_EC2_SG"
  }
}

#ingress ssh from pub instance only
module "prv_ec2_sg_ingress" {
  source = "../modules/sg_rules_sg"
  
  type = "ingress"
  description = "Allows Inbound SSH access to only public EC2, rest are restricted"
  from_port = "${var.ssh_port}"
  to_port = "${var.ssh_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_ec2_sg.security_group_id}"
  source_security_group_id = "${module.pub_ec2_sg.security_group_id}"
}

#egress http all ip
module "prv_ec2_sg_egress1" {
  source = "../modules/sg_rules_cidr"
  
  type = "egress"
  description = "Allows HTTP access to all IP"
  from_port = "${var.http_port}"
  to_port = "${var.http_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_ec2_sg.security_group_id}"
  cidr_blocks = "${var.internet_cidr_blocks}"
}

#egress https all ip
module "prv_ec2_sg_egress2" {
  source = "../modules/sg_rules_cidr"
  
  type = "egress" 
  description = "Allows HTTPS access to all IP"
  from_port = "${var.https_port}"
  to_port = "${var.https_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_ec2_sg.security_group_id}"
  cidr_blocks = "${var.internet_cidr_blocks}"
}

#egress mysql to rds instance
module "prv_ec2_sg_egress3" {
  source = "../modules/sg_rules_sg"
  
  type = "egress"
  description = "Allows HTTPS access to all IP"
  from_port = "${var.mysql_port}"
  to_port = "${var.mysql_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_ec2_sg.security_group_id}"
  source_security_group_id = "${module.prv_rds_sg.security_group_id}"
}

#Private rds sg
module "prv_rds_sg" {
  source = "../modules/sg"
  name = "Private_RDS_SG"
  description = "Security group for the private rds instance, allows only MySQL access inbound and outbound , rest restricted"
  vpc_id = "${module.my_vpc.vpc_id}"
  tags = {
    Name = "Private_RDS_SG"
  }
}

#ingress mysql from private ec2
module "prv_rds_sg_ingress" {
  source = "../modules/sg_rules_sg"
  
  type = "ingress"
  description = "Allows Inbound MySQL access to only private EC2, rest are restricted"
  from_port = "${var.mysql_port}"
  to_port = "${var.mysql_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_rds_sg.security_group_id}"
  source_security_group_id = "${module.prv_ec2_sg.security_group_id}"
}

#egress mysql to private ec2
module "prv_rds_sg_egress" {
  source = "../modules/sg_rules_sg"
  
  type = "egress"
  description = "Allows Outbound MySQL access to only private EC2, rest are restricted"
  from_port = "${var.mysql_port}"
  to_port = "${var.mysql_port}"
  protocol = "tcp"
  security_group_id = "${module.prv_rds_sg.security_group_id}"
  source_security_group_id = "${module.prv_ec2_sg.security_group_id}"
}

#The private rds instance
module "private_rds" {
  source = "../modules/rds"
  subnet_grp_name = "${var.subnet_grp_name}"
  subnet_ids = ["${module.my_vpc.private_subnet1_id}","${module.my_vpc.private_subnet2_id}"]
  identifier = "${var.rds_identifier}"
  db_name = "${var.db_name}"
  db_username = "${var.db_username}"
  db_password = "${var.db_password}"
  vpc_security_group_ids = ["${module.prv_rds_sg.security_group_id}"]
}

#Public ec2 instance
module "public_ec2" {
  source = "../modules/ec2"
  subnet_id = "${module.my_vpc.public_subnet_id}"
  key_name  = "${var.key_name}"
  vpc_security_group_ids = ["${module.pub_ec2_sg.security_group_id}"]
  tags = {
    Name = "Public EC2 instance"
  }
}

#Private ec2 instance which has a startup script to install and connect to mysql rds instance, perform create insert and store the file, can be verfied by ssh into instance
module "private_ec2" {
  source = "../modules/ec2"
  ami = "${var.private_ami}"
  subnet_id = "${module.my_vpc.public_subnet_id}"
  associate_public_ip_address = "0"
  key_name  = "${var.key_name}"
  vpc_security_group_ids = ["${module.prv_ec2_sg.security_group_id}"]
  user_data = <<EOF
    #!/bin/bash
    yum update -y
    mkdir /home/ec2-user/rds-check-log
    echo "starting MySql installation" >> /home/ec2-user/rds-check-log/start-up.log
    yum install mysql-server -y
    echo "MySQL installed" >> /home/ec2-user/rds-check-log/start-up.log
    /sbin/service mysqld start
    mysqladmin -u root password 'toor'
    RDS_MYSQL_ENDPOINT="${element(split(":", module.private_rds.rds_endpoint), 0)}";
    RDS_MYSQL_USER="${var.db_username}";
    RDS_MYSQL_PASS="${var.db_password}";
    RDS_MYSQL_BASE="${var.db_name}";
    mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE -e 'quit';
    if [[ $? -eq 0 ]]; then
      echo "MySQL connection: OK" >> /home/ec2-user/rds-check-log/conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='CREATE TABLE shriram( id INT)';
      echo "MySQL table create" >> /home/ec2-user/rds-check-log/conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='INSERT into shriram (id) VALUES (1)';
      echo "MySQL insert" >> /home/ec2-user/rds-check-log/conn;
      mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE --execute='SELECT * from shriram' >> /home/ec2-user/rds-check-log/table-output;
      echo "MySQL select" >> /home/ec2-user/rds-check-log/conn;
    else
      echo "MySQL connection: Fail" >> /home/ec2-user/rds-check-log/conn;
    fi;
    EOF

  tags = {
    Name = "Private EC2 instance"
  }
}