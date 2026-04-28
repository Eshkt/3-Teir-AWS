resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = "${var.project_name}-vpc"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.public_subnet_cidr 
    availability_zone = "${var.region}a"
    tags = {
        Name = "${var.project_name}-public-subnet"
    }
}

#Internet Gateway to allow traffic in and out
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "${var.project_name}-igw"
    }
  
}