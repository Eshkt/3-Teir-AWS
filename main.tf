#block 1
module "vpc_region_a" {
  source             = "./modules/vpc"
  region             = "us-east-1"
  vpc_cidr           = "10.1.0.0/16"
  public_subnet_cidr = "10.1.1.0/24"
  project_name       = "three-teir-platform"
}

#block 2
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc_region_a.vpc_id
  project_name = "three-teir-platform"
}