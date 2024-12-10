resource "aws_key_pair" "scope_key" {
  key_name   = "scope_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_security_group" "sg_22_80" {
  name   = "sg_22"
  vpc_id = var.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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


data "aws_ami" "my_ami" {
  owners = ["self"]  // 'self' refers to your own AWS account

  filter {
    name   = "name"
    values = ["ami-scopeinfotech-*"]
  }
  most_recent = true
}

output "ami_id" {
  value = data.aws_ami.my_ami.id
}


resource "aws_instance" "test_ami_server" {
  ami                         = data.aws_ami.scope_ami.id
  instance_type               = "t3a.medium"
  subnet_id                   = var.subnets[0]
  vpc_security_group_ids      = [aws_security_group.sg_22_80.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.scope_key.key_name

  tags = {
    Name = "Test_Instance"
  }

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}


output "public_ip" {
  value = aws_instance.test_ami_server.public_ip
}


