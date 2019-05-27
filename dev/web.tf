provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "core" {
  backend = "remote"
  config = {
    hostname     = "${var.tfe_hostname}"
    organization = "${var.organization}"
    token        = "${var.token}"

    workspaces = {
      name = "${var.workspace-core}"
    }
  }
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.21.0"

  ami                         = "${lookup(var.www_ami, var.region)}"
  instance_type               = "${var.www_instance_type}"
  name                        = "devops"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.core.default_security_group_id}"]
  subnet_id                   = "${data.terraform_remote_state.core.public_subnet_ids[0]}"
  associate_public_ip_address = true
  tags = {
    Owner = "heewon1.kim"
    TTL = "${timestamp()}"
  }
}
