#############################################################################
# VARIABLES
#############################################################################

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.100.0/24", "10.0.101.0/24"]
}

variable "intra_subnets" {
  type    = list(string)
}


provider
  


# DATA SOURCES


data "aws_availability_zones" "azs" {}

#############################################################################
# RESOURCES
  

# Create security VPC

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"
  name = "sec-vpc"
  cidr = var.vpc_cidr_range

  azs             = slice(data.aws_availability_zones.azs.names, 0, 2)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  intra_subnets   = var.intra_subnets

  tags = {
    Environment = "all"
    Team        = "security"
  }

}

#############################################################################
# OUTPUTS
