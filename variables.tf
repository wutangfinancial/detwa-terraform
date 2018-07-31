provider "aws" {
  version = "~> 1.27"
  region = "us-east-1"
}

variable "my_ami" {
  type    = "string"
  default = "ami-b70554c8"
}

variable "my_subnet" {
  type    = "string"
  default = "subnet-3805d964"
}

variable "my_key" {
  type    = "string"
  default = "amzn-detwa-east"
}

variable "my_concourse_web_secgroups" {
  type    = "list"
  default = ["sg-01954e4a","sg-f915f0b3","sg-005fba4a"]
}

variable "my_concourse_worker_secgroups" {
  type    = "list"
  default = ["sg-01954e4a","sg-6805e022","sg-005fba4a"]
}

variable "my_postgresdb_secgroups" {
  type    = "list"
  default = ["sg-01954e4a","sg-873a2fcc","sg-005fba4a"]
}

variable "my_bastion_ring_secgroups" {
  type    = "list"
  default = ["sg-01954e4a","sg-005fba4a"]
}

variable "my_route53_zone_id" {
  type    = "string"
  default = "Z20NBA4QJSYPCC"
}
