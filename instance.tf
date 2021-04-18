resource "aws_instance" "first_instance" {
  ami                         = "ami-0885b1f6bd170450c"
  instance_type               = "t2.micro"
  key_name                    = "kp1"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}"]
  subnet_id                   = aws_subnet.subnet1.id
  user_data                  = file("apache.sh")
  associate_public_ip_address = true

  tags = {
    Name = "server1"
  }
}
resource "aws_instance" "sec_instance" {
  ami                         = "ami-0885b1f6bd170450c"
  instance_type               = "t2.micro"
  key_name                    = "kp1"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}"]
  subnet_id                   = aws_subnet.subnet1.id
  user_data                   = file("apache.sh")
  associate_public_ip_address = true
  tags = {
    Name = "server2"
  }
}
  resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound connections"
  vpc_id      = aws_vpc.my_app.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
