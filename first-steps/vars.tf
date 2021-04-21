variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1    = "ami-042e8287309f5df03"
    eu-central-1 = "ami-0767046d1677be5a0"
    eu-west-1    = "ami-031b673f443c2172c"
  }
}
