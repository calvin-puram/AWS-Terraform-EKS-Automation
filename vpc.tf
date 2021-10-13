

provider "aws" {
	region = "us-east-2"
}

data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"
  
  name = "myapp-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnets_cidr_blocks
  public_subnets = var.public_subnets_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
   "kubernetes.io/cluster/myapp-cluster" = "shared"
  }

  private_subnet_tags = {
   "kubernetes.io/cluster/myapp-cluster" = "shared"
   "kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
   "kubernetes.io/cluster/myapp-cluster" = "shared"
   "kubernetes.io/role/elb" = 1
  }

}