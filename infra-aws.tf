terraform {
    required_providers {

        aws = {
            source = "hashicorp/aws"
            version = "~> 2.70"
        }
    }

}

provider "aws" {
    profile = "default"
    region = "eu-west-2"
    
}
#
# resource "aws_instance" "App01" {
#     instance_type = "t2.micro"
#     ami = "ami-05c424d59413a2876"
#     tags = {
#         Name = "App1Machine"    
#     }
#     key_name = "terraform-ec2"
# }

# resource "aws_instance" "App2" {
#     instance_type = "t2.micro"
#     ami = "ami-05c424d59413a2876"
#     tags = {
#         Name = "App2Machine"
#     }
#     key_name = "terraform-ec2"
# }

#resource "aws_s3_bucket" "starbucket" {
#   bucket = "mybucketokirjt"
#   acl = "private"
#   versioning {
#      enabled = true
#   }
#   tags = {
#     Name = "Bucket1"
#     Environment = "Test"
#   }
#}


#variable "s3_bucket_name1" {
#   type = "list"
#   default = ["terr-ashfaq-buc-1", "terr-ashfaq-buc-2", "terr-ashfaq-buc-3"]
#}
#resource "aws_s3_bucket" "henrys_bucket_jjuue" {
#   count = "${length(var.s3_bucket_name1)}"
#   bucket = "${var.s3_bucket_name1[count.index]}"
#   acl = "private"
#   versioning {
#      enabled = true
#   }
#   force_destroy = "true"
#}


# S3 bucket for storing extracts as cache
#vip_bucket_uujrut

#
data "aws_iam_role" "ecs_service_task_role" {
  name = "ecsInstanceRole"
}

variable "environment_id" {
  type = string
  description = "desc"
  default = "build4"
}

variable "gp2gp_extract_cache_bucket_retention_period" {
  type = number
  description = "desc2"
  default = 4  
}


############################################################################################
#/*
# S3 bucket for storing extracts as cache
resource "aws_s3_bucket" "gp2gp_extract_cache_bucket" {
  bucket = "${var.environment_id}-gp2gp-extract-cache-bucket"
  tags = {
    Name = "${var.environment_id}-gp2gp-extract-cache-bucket"
    EnvironmentId = var.environment_id
  }
  lifecycle_rule {
    id      = "cache_retention_period"
    enabled = true
    expiration {
      days = var.gp2gp_extract_cache_bucket_retention_period
    }
  }
}

# S3 bucket policy for GP2GP extract cache bucket.

resource "aws_s3_bucket_policy" "gp2gp_extract_cache_bucket_policy" {
  bucket = aws_s3_bucket.gp2gp_extract_cache_bucket.id

  policy = jsonencode(
  {
    Id = "GP2GPExtractCacheBucketPolicy"
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowECSTaskRole"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.gp2gp_extract_cache_bucket.arn}/*" 
        Principal = {
          AWS = data.aws_iam_role.ecs_service_task_role.arn
        }
      }
    ]
  }
  )
}

# Disable any public access to bucket
resource "aws_s3_bucket_public_access_block" "gp2gp_extract_cache_bucket_public_access_block" {
  bucket = aws_s3_bucket.gp2gp_extract_cache_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  # Need to make sure not to try and disable public access at the same time as adding the
  # bucket policy, as trying to do both at the same time results in an error.
  depends_on = [
    aws_s3_bucket_policy.gp2gp_extract_cache_bucket_policy
  ]
}
#*/
############################################################################################
/*
# S3 bucket for storing extracts as cache
resource "aws_s3_bucket" "vip_bucket" {
    bucket = "${var.environment_id}-vip-bucket-jjuuhf"
    tags = {
        Name = "${var.environment_id}-vip-bucket-jjuuhf"
        EnvironmentId = var.environment_id
    }
    lifecycle_rule {
        id      = "cache_retention_period"
        enabled = true
        expiration {
            days = var.vip_bucket_retention_period
        }
    }
       
}

# S3 bucket policy for GP2GP extract cache bucket.

resource "aws_s3_bucket_policy" "vip_bucket_policy" {
  bucket = aws_s3_bucket.vip_bucket.id

  policy = jsonencode(
  {
    Id = "GP2GPExtractCacheBucketPolicyssdf232ew"
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowECSTaskRole234qwerfsdf"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.vip_bucket.arn}/*"  ##"arn:aws:s3:::${vip_bucket.bucket}/*"
        Principal = {
          AWS = data.aws_iam_role.ecs_service_task_role.arn
        }
      }
    ]
  }
  )
}

# Disable any public access to bucket
resource "aws_s3_bucket_public_access_block" "vip_bucket_public_access_block_sdfwer234w" {
  bucket = aws_s3_bucket.vip_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  # Need to make sure not to try and disable public access at the same time as adding the
  # bucket policy, as trying to do both at the same time results in an error.
  depends_on = [
    aws_s3_bucket_policy.vip_bucket_policy
  ]
}
*/
########
