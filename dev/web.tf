provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "dev" {
  id = "${var.vpc_id}"
}

data "aws_security_groups" "dev" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.dev.id}"]
  }
}

data "aws_security_group" "dev" {
  count = "${length(data.aws_security_groups.dev.ids)}"
  id    = "${data.aws_security_groups.dev.ids[count.index]}"
}

data "aws_subnet_ids" "dev" {
  vpc_id = "${var.vpc_id}"
}

data "aws_subnet" "dev" {
  count = "${length(data.aws_subnet_ids.dev.ids)}"
  id    = "${data.aws_subnet_ids.dev.ids[count.index]}"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.21.0"

  name                        = "${var.name}"
  instance_count              = "${var.instance_count}"
  instance_type               = "${var.instance_type}"
  ami                         = "${lookup(var.www_ami, var.region)}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${data.aws_security_group.dev.*.id}"]
  subnet_id                   = "${data.aws_subnet_ids.dev.ids[1]}"
  associate_public_ip_address = true
  tags = {
    Owner = "${var.owner}"
    TTL = "${timestamp()}"
  }
}

output "vpc-id" {
  value = "${data.aws_vpc.dev.id}"
}

output "sg-1" {
  value = ["${data.aws_security_group.dev.*.id}"]
}

output "subnet_cidr_blocks" {
  value = ["${data.aws_subnet.dev.*.cidr_block}"]
}
