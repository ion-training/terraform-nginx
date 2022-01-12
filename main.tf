terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

variable "prefix_name" {
  description = "prefix of the tags, defaults to `ion` string "
  default     = "ion"
  type        = string
}

variable "region" {
  description = "provide region where to create the resources"
  default     = "eu-north-1"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "random_pet" "suffix_name" {
  length = 1
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix_name}-vpc-${random_pet.suffix_name.id}"
  }
}

resource "aws_subnet" "subnet_web" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "${var.prefix_name}-subnet-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.prefix_name}-route-table-${random_pet.suffix_name.id}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_web.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix_name}-gw-${random_pet.suffix_name.id}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "keys" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.prefix_name}-ssh-key-${random_pet.suffix_name.id}"
  public_key = tls_private_key.keys.public_key_openssh
  tags = {
    Name = "${var.prefix_name}-key-pair-${random_pet.suffix_name.id}"
  }
}

resource "local_file" "ssh-key-file" {
  content  = tls_private_key.keys.private_key_pem
  filename = "./artifacts/id_rsa.priv"
  provisioner "local-exec" {
    command = "chmod 400 ./artifacts/id_rsa.priv"
  }
}

resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Enter SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Enter HTTP"
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

  tags = {
    Name = "${var.prefix_name}-web-server-${random_pet.suffix_name.id}"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet_web.id
  key_name                    = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.web-server.id]
  tags = {
    Name = "${var.prefix_name}-ubuntu"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]

  user_data = <<-EOF
  #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update
    sudo apt-get install -y nginx
  EOF
}

output "connect_URL" {
  description = "connect on bellow URL on port 80"
  value       = "http://${aws_instance.web.public_dns}"
}

output "connect_SSH" {
  value = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.web.public_ip}"
}
