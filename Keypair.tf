#=============================================================
#Key pair
#=============================================================
resource "tls_private_key" "test" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "BSH_key" {
  key_name = "BSH_key"
  public_key = tls_private_key.test.public_key_openssh
}

resource "local_file" "local_BSH_key" {
  filename = "${aws_key_pair.BSH_key.key_name}.pem" 
  content = tls_private_key.test.private_key_pem  
}