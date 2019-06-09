provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "dev" {
  id = "vpc-0224580e6e66e24d1"
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
