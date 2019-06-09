provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "dev" {
  id = "vpc-0224580e6e66e24d1"
}

data "aws_security_groups" "dev" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.dev.id}"]
  }
}

data "aws_security_group" "dev" {
  count = "${length(data.aws_security_groups.dev.ids)}"
  id    = "${data.aws_security_groups.dev.ids[count.index]}"
}

output "vpc-id" {
  value = "${data.aws_vpc.dev.id}"
}

output "sg-1" {
  value = "${data.aws_security_group.dev.*.id}"
}
