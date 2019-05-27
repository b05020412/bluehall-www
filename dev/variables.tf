variable "region" {
  default = "us-east-1"
  description = "The name of region"
}

variable "prefix" {
  default = "paraconsistent.com"
  description = "The name of our org, i.e. example.com."
}

variable "key_name" {
  default = "www-dev"
  description = "ssh pem key pair"
}

variable "environment" {
  default = "dev"
  description = "The name of the environment"
}

variable "bastion_ami" {
  default = {
    "us-east-1" = "ami-f652979b"
    "us-west-1" = "ami-7c4b331c"
    "eu-west-1" = "ami-0ae77879"
  }

  description = "The AMIs to use for web and app instances."
}

variable "bastion_instance_type" {
  default     = "t2.micro"
  description = "The instance type to launch "
}
