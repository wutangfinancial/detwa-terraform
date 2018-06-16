provider "aws" {
  version = "~> 1.23"
  region = "us-east-1"
}

variable "my_ami" {
  type    = "string"
  default = "ami-14c5486b"
}

variable "my_subnet" {
  type    = "string"
  default = "subnet-3805d964"
}

variable "my_key" {
  type    = "string"
  default = "amzn-detwa-east"
}

variable "my_jenkins_secgroups" {
  type    = "list"
  default = ["sg-4699420d","sg-01954e4a","sg-c213c889"]
}

  
