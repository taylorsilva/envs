locals {
  aws_region         = ""
  vpc_id             = "vpc-"
  subnet_id          = "subnet-"
  tailscale_auth_key = "tskey-auth-GENERATE-KEY"
}

module "ubuntu-tailscale-client" {
  source              = "github.com/tailscale/terraform-cloudinit-tailscale"
  auth_key            = local.tailscale_auth_key
  enable_ssh          = true
  hostname            = "sydney"
  advertise_exit_node = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "main" {
  vpc_id      = local.vpc_id
  description = "Tailscale required traffic"

  ingress {
    from_port   = 41641
    to_port     = 41641
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tailscale UDP port"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

resource "aws_instance" "node" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  subnet_id       = local.subnet_id
  security_groups = [aws_security_group.main.id]

  ebs_optimized = true

  user_data_base64            = module.ubuntu-tailscale-client.rendered
  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}
