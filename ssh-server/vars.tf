variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "myKey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "myKey.pub"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-042e8287309f5df03"
    eu-central-1 = "ami-0767046d1677be5a0"
    eu-west-1 = "ami-031b673f443c2172c"
  }
}