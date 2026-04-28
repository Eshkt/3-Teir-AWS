#Global variables for the project
variable "project_name" {
  description = "Three Tier AWS Project"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "region" {
    description = "AWS region"
    type = string
}