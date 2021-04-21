variable "AWS_ACCESS_KEY" {
  default = "AKIARF7TPCBYPR2DZRM3"
}
variable "AWS_SECRET_KEY" {
  default = "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"
}
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