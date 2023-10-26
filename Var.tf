##############################################################################
#                               vpc variable                                 #
##############################################################################
 
variable "vpc_cidr" {
    description = "VPC cidr block"
    type = string
}
 
variable "vpc_name" {
    default = ""
}
 
variable "PUB_subnet_cidr" {
 
}
 
variable "PUB_subnet_name" {
    default = ["BSH_PUB-1", "BSH_PUB-2"]
}
 
variable "availability_zones" {
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}
 
variable "APP_subnet_cidr" {
     
}
 
variable "APP_subnet_name" {
    default = ["BSH_APP-1", "BSH-APP-2"]
}

variable "DnG_subnet_cidr" {
     
}
 
variable "DnG_subnet_name" {
    default = ["BSH_DnG-1", "BSH-DnG-2"]
}

variable "PRI_subnet_cidr" {
  default = [var.APP_subnet_cidr, var.DnG_subnet_cidr]
}
 
variable "PUB_RT_name" {
    default = "PUB_RT"
}
 
variable "PRI_RT_name" {
    default = ["PRI_RT1", "PRI_RT2"]
}
 
variable "internet_gateway_name" {
    default = "BSH_IGW"
}

variable "Nat_gateway_name" {
    default = ["BSH_NATG-1", "BSH_NATG-2"]
}
 
variable "anyway_ipv4_cidr" {
    default = "0.0.0.0/0"
}
 
##############################################################################
#                               ec2 variable                                 #
##############################################################################
 
variable "ami" {
   
}
 
variable "instance_type" {
   
}

variable "key_server_name" {
  
}
 
variable "app_server_name" {
   
}
 
variable "db_server_name" {
   
}
 
variable "grafana_server_name" {
     
}
 
variable "database_name" {
     
}
 
variable "database_password" {
   
}