terraform {
  required_providers {
    aws       = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = "ap-northeast-2"
  access_key = 
  secret_key = 
}