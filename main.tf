module "vpc_region_a" {
  source             = "./modules/vpc"
  region             = "us-east-1"
  vpc_cidr           = "10.1.0.0/16"
  public_subnet_cidr = "10.1.1.0/24"
  project_name       = "three-teir-platform"
}