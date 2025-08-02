provider "aws" {
  region = var.region
}

resource "aws_security_group" "app_sg" {
  name = "app-sg"
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
  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_instance" "app" {
  ami           = "ami-xxxxxx"
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  tags = { Name = "app-server" }
}

resource "aws_instance" "nginx" {
  ami           = "ami-xxxxxx"
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  tags = { Name = "nginx-server" }
}