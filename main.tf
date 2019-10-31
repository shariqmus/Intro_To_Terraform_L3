provider "aws" {
    region = "${var.region}"
}

resource aws_s3_bucket "my-bucket" {
    bucket = "${var.s3_bucket_name}"
    tags = { Name = "terraform-l3-bucket-1"}
}


variable "region" {
    type = "string"
    default = "ap-southeast-2"
}

variable "s3_bucket_name" {
    type = "string"
    default = "terraform-l3-bucket-1"

}

output "s3_bucket_domain_name" {
    value = "${aws_s3_bucket.my-bucket.bucket_domain_name}"
}

module "terraform_module_test" {

    source = "./modules"
    module_bucket_name = "terraform-l3-bucket-1-from-module"
    module_queue_name = "terraform-l3-queue-from-module"
}

output "module_queue_name" {
  value = "${module.terraform_module_test.module_queue_name}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}