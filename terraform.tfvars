#Terraform variable

vpc_cidr = "10.0.0.0/16"
PUB_subnet_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
APP_subnet_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
DnG_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24"]

vpc_name = "terraform_vpc"
PRI_RT_name = ["PRI_RT-1", "PRI_RT-2"]
 
ami = "ami-0c9c942bd7bf113a2"
instance_type = "t2.micro"
key_server_name = "Keycloak"
app_server_name = "APP"
InfluxDB_name = "InfluxDB" # InfluxDB ASG으로 생성할떄 사용
# InfluxDB_name = ["InfluxDB-1", "InfluxDB-2"] # Influx DB EC2로 생성할때 사용
grafana_server_name = "Grafana"

database_name = "test"
# database_name2 = ["test1", "test2"] # InfluxDB ASG으로 생성할떄 사용
database_password = "password"