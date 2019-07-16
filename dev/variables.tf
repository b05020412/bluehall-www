variable "region" {
  default = "cn-north-1"
  description = "The name of region"
}

variable "name" {
  default = "devops"
  description = "name of instance"
}

variable "vpc_id" {
  default = "vpc-0d521069"
  description = "VPC id"
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
    "cn-north-1" = "ami-08b835182371dee58"
    "us-west-1" = "ami-7c4b331c"
    "eu-west-1" = "ami-0ae77879"
  }

  description = "The AMIs to use for web and app instances."
}

variable "instance_count" {
  default = 1
  description = "number of instances"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The instance type to launch "
}

variable "token" {
  default = ""
  description = "token for accessing other workspaces"
}

variable "workspace-core" {
  default = ""
  description = "workspace where core state info is resided in"
}

variable "organization" {
  default = "vdsrcn"
  description = "organization name"
}

variable "owner" {
  default = ""
  description = "owner name"
}

variable "tfe_hostname" {
  default = "app.terraform.io"
  description = "TFE hostname"
}
