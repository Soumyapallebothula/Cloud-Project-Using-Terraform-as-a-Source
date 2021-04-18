resource "aws_instance" "web" {
  count                  = 1
  ami                    = var.web_ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub-subnet.id
  vpc_security_group_ids = ["${aws_security_group.pub_sg.id}"]
  key_name               = "kp1"
  associate_public_ip_address = "true"

  tags = {
    Name = "web-server"
  }
}

#Create security groups for web-servers
resource "aws_security_group" "pub_sg" {
  name        = "pub_sg-sg"
  vpc_id      = aws_vpc.my_app.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
