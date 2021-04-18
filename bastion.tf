resource "aws_instance" "bastionhost" {
  #count                  = 1
  ami                    = "ami-00a9d4a05375b2763"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub-subnet.id
  vpc_security_group_ids = ["${aws_security_group.pub_sg.id}"]
  key_name               = "kp1"
  source_dest_check      = false
  associate_public_ip_address = "true"
  tags = {
    Name = "bastionhost"
  }
}
# Configure security group for webservers

resource "aws_security_group" "bas_sg" {
  name        = "bas_sg-sg"
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
