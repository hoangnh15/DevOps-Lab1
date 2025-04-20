# main.tf - Sample Terraform configuration

# Specify the provider
provider "aws" {
    region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "example" {
    bucket = "example-bucket-name"
    acl    = "private"

    tags = {
        Name        = "ExampleBucket"
        Environment = "Dev"
    }
}

# Output the bucket name
output "bucket_name" {
    value = aws_s3_bucket.example.bucket
}