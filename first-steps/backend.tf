terraform {
  backend "s3" {
    bucket = "terraform-state-course-example"
    key    = "terraform/demo"
    region = "eu-central-1"
  }
}