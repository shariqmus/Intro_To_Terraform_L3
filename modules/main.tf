resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "${var.module_bucket_name}"
}

resource "aws_sqs_queue" "terraform_queue" {
  name = "${var.module_queue_name}"
}

terraform {
  required_version = "~> 0.12"

  backend "s3" {
    region         = "ap-southeast-2"
    encrypt        = true
    bucket         = "tfl3-terraform-backend"
    key            = "terraform.tfstate"
    dynamodb_table = "tfl3-tfstatelock"
  }
}