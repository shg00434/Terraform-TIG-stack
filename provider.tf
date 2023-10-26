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
  access_key = "AKIARF5M34LI753N3BAI"
  secret_key = "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"
}