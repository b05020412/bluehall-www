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

  name                        = "${var.name}"
  instance_count              = "${var.instance_count}"
  instance_type               = "${var.instance_type}"
  ami                         = "${lookup(var.www_ami, var.region)}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.core.default_security_group_id}"]
  subnet_id                   = "${data.terraform_remote_state.core.public_subnet_ids[0]}"
  associate_public_ip_address = true
  tags = {
    Owner = "${var.owner}"
    TTL = "${timestamp()}"
  }
}
