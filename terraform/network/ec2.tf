resource "aws_instance" "app" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  // This resource will fail the Sinistral scan because it has a public IP 
  // address and is allowing SSH from anywhere. Fix it by changing the line
  // below to "false".
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
