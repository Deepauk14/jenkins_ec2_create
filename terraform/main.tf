resource "aws_security_group" "web_sg" {
  name = "web-sg"

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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-00ca570c1b6d79f36"
  instance_type          = "t3.micro"
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "Jenkins-Web-Server"
  }
}

