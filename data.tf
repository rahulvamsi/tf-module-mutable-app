data "aws_ssm_parameter" "ssh_credentials" {
  name = "ssh.credentials"
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "ansible_installed"
  owners      = ["self"]
}

data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "terraform-rb66"
    key    = "mutable/infra/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_route53_zone" "private" {
  name         = "roboshop.internal"
  private_zone = true
}


