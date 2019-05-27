variable "region" {
  default = "us-east-1"
  description = "The name of region"
}

variable "key_name" {
  default = "devops"
  description = "ssh pem key pair"
}

variable "environment" {
  default = "dev"
  description = "The name of the environment"
}

variable "www_ami" {
  default = {
    "us-east-1" = "ami-f652979b"
    "us-west-1" = "ami-7c4b331c"
    "eu-west-1" = "ami-0ae77879"
  }

  description = "The AMIs to use for web and app instances."
}

variable "www_instance_type" {
  default     = "t2.micro"
  description = "The instance type to launch "
}
