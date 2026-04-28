#First provider block for Region A
provider "aws" {
    region = "us-east-1" #Region A
}

#Second provider block for Region B
provider "aws" {
    alias = "region_b"
    region = "us-west-1" #Region B
}

terraform {
    required_version = ">= 1.5.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}