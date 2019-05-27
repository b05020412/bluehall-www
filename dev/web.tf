provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "core" {
  backend = "atlas"
  config {
    name = "vdsec/bluehall-core-dev"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "${lookup(var.bastion_ami, var.region)}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-0e4af5dec5a1bc2c0"]
  subnet_id                   = "subnet-0f54a4cf7538d2029"
  associate_public_ip_address = true

  tags {
    Name = "${var.environment}-bastion"
  }
}
