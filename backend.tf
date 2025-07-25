terraform {
  backend "s3" {
    bucket = "terraform-state-chaitanya-ec2-2025"
    key    = "day40/terraform.tfstate"
    region = "ap-south-1"
  }
}
