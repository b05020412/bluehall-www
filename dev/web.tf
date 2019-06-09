provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "dev" {
  tags {
    Name = "dev"
  }
}

data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.dev.id}"
}

output "vpc-id" {
  value = "${data.aws_vpc.dev.id}"
}

output "sg-1" {
  value = "${data.aws_security_group.default.id}"
}
