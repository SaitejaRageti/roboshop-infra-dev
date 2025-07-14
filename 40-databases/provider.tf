terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
  bucket = "saiteja-practice-state"
  key    = "mongodb-module-infra"
  region = "us-east-1"
  use_lockfile = true
  encrypt = true

  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

