resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = tls_private_key.my_key.public_key_openssh
}

