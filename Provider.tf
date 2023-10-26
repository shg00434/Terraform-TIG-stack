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
  access_key = "AKIARF5M34LI2S6SHMNT"
  secret_key = "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"
}