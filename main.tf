terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = var.region
    access_key = var.AWS_ACCESS_TOKENS["id"]
    secret_key = var.AWS_ACCESS_TOKENS["access_key"]
}

resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    tags = {
        Name = "Terraform Backend"
    }
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
    bucket = aws_s3_bucket.bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}