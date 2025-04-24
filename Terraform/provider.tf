terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"        
                      
    }
  }
}

# Cấu hình chi tiết cho provider AWS.
provider "aws" {
  region = var.aws_region

  # --- Phần xác thực (Authentication) ---
  
}