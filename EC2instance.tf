resource "aws_instance" "Bastion" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.bastion_sg]
    subnet_id = aws_subnet.PUB_subnet[0].id
    associate_public_ip_address = true
    key_name = aws_key_pair.BSH_key.key_name

    provisioner "file" {
      source      = "./${aws_key_pair.BSH_key.key_name}.pem"
      destination = "/home/ubuntu/${aws_key_pair.BSH_key.key_name}.pem"
    }

    provisioner "remote-exec" {
      inline = [
      "chmod 600 ${aws_key_pair.BSH_key.key_name}.pem"
    ]
    }

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${aws_key_pair.BSH_key.key_name}.pem")
      host        = self.public_ip
    }
  
}