terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      region = "us-east-1"
      alias  = "aft_management"
    }
  }
}
