
#Create DB-servers
resource "aws_instance" "db-server" {
  ami                    = var.web_ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub-subnet.id
  vpc_security_group_ids = ["${aws_security_group.priv_sg.id}"]
  key_name               = "kp1"

  tags = {
    Name = "db-server"
  }
}

# Configure security group for dbservers
resource "aws_security_group" "priv_sg" {
  name        = "priv_sg-sg"
  vpc_id      = aws_vpc.my_app.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.49/32"]
    }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
