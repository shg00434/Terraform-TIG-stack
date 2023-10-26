#=============================================================
#ASG
#=============================================================

#Application host ASG
resource "aws_autoscaling_group" "Application_ASG" {
    name = "APP_ASG"
    desired_capacity = 2
    max_size = 2
    min_size = 2
    health_check_grace_period = "300"
    health_check_type = "EC2"
    vpc_zone_identifier = [aws_subnet.APP_subnet[0].id, aws_subnet.APP_subnet[1].id ]
    launch_template {
      id = aws_launch_template.Application_LT.id
      version = aws_launch_template.Application_LT.latest_version
    }
    target_group_arns = [aws_alb_target_group.APP_TG.arn]

    lifecycle {
      create_before_destroy = true
    }
}

#InfluxDB host ASG
resource "aws_autoscaling_group" "InfluxDB_ASG" {
    name = "InfluxDB_ASG"
    desired_capacity = 1
    max_size = 2
    min_size = 1
    vpc_zone_identifier = [aws_subnet.DnG_subnet[0].id, aws_subnet.DnG_subnet[1].id]
    launch_template {
      id = aws_launch_template.DB_LT.id
      version = aws_launch_template.DB_LT.latest_version
    }
    target_group_arns = [aws_alb_target_group.DB_TG.arn]
    lifecycle {
      create_before_destroy = true
    }
}

#Grafana host ASG
resource "aws_autoscaling_group" "Grafana_ASG" {
    name = "Grafana_ASG"
    desired_capacity = 1
    max_size = 2
    min_size = 1
    vpc_zone_identifier = [aws_subnet.DnG_subnet[0].id, aws_subnet.DnG_subnet[1].id]
    launch_template {
      id = aws_launch_template.Grafana_LT.id
      version = aws_launch_template.Grafana_LT.latest_version
    }
    target_group_arns = [aws_alb_target_group.Grafana_TG.arn]
    lifecycle {
      create_before_destroy = true
    }
}