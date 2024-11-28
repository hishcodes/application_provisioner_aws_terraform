resource "aws_instance" "my_instance" {
  ami                         = "ami-0453ec754f44f9a4a"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.my_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../flask_app/app.py"
    destination = "/home/ec2-user/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/templates"
    ]
  }

  provisioner "file" {
    source      = "../flask_app/templates/index.html"
    destination = "/home/ec2-user/templates/index.html"
  }


  provisioner "remote-exec" {
    inline = [
      "echo 'Remote instance is now running'",
      "sudo dnf update",
      "sudo yum install -y python3-pip",
      "cd /home/ec2-user/",
      "sudo pip3 install flask",
      "sudo python3 app.py"
    ]
  }

}