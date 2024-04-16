provider "aws" {
  region  = "us-east-1"
  profile = "my-profile"
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr
  public_subnet3_cidr = var.public_subnet3_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
  private_subnet3_cidr = var.private_subnet3_cidr
}

module "ecr" {
  source = "./modules/ecr"
  environment_name = var.environment_name
}

terraform {
  backend "s3" {
    bucket = "my-terraformstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt        = false
    profile = "my-profile"
   
  }
  
}
