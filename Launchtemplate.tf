
#=============================================================
#Launch template
#=============================================================

#Application 
resource "aws_launch_template" "Application_LT" {
    name = "BSH-Application"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.BSH_key.key_name
    monitoring {
      enabled = true
    }
    vpc_security_group_ids = [aws_security_group.APP_SG.id]
    user_data = base64encode(templatefile("./Appdata.sh", {
    localhost = aws_alb.BSH_APP_ALB.dns_name,
    database = var.database_name,
    database_password = var.database_password
    }))
    tags = {
    Name =  var.app_server_name
    }
}

#Application #InfluxDB EC2로 생성하였을시
# resource "aws_launch_template" "Application_LT" {
#     name = "BSH-Application"
#     image_id = var.ami
#     instance_type = var.instance_type
#     key_name = aws_key_pair.BSH_key.key_name
#     monitoring {
#       enabled = true
#     }
#     vpc_security_group_ids = [aws_security_group.APP_SG.id]
#     user_data = base64encode(templatefile("./Appdata1-1.sh", { # Influx DB EC2로 생성할때 사용
#     dbaddress1 = aws_instance.InfluxDB[0].private_dns, # Influx DB EC2로 생성할때 사용
#     dbaddress2 = aws_instance.InfluxDB[1].private_dns, # Influx DB EC2로 생성할때 사용
#     database = var.database_name2[count.index], # Influx DB EC2로 생성할때 사용
#     database_password = var.database_password
#     }))
#     tags = {
#     Name =  var.app_server_name
#     }
# }

#InfluxDB
resource "aws_launch_template" "DB_LT" {
  name = "BSH-InfluxDB"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.BSH_key.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.InfluxDB_SG.id]
  user_data = "${filebase64("./InfluxDBdata.sh")}"
  tags = {
    Name =  var.InfluxDB_name
  }
}

#Grafana
resource "aws_launch_template" "Grafana_LT" {
  name          = "BSH-Grafana"
  image_id = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.BSH_key.key_name
  monitoring {
    enabled     = true
  }
  vpc_security_group_ids = [aws_security_group.Grafana_SG.id]
  user_data     = base64encode(templatefile("./Grafanadata.sh", {
  localhost   = aws_alb.BSH_APP_ALB.dns_name
  }))
  tags = {
    Name =  var.grafana_server_name
  }
}