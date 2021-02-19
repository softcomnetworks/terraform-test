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

 resource "aws_instance" "App01" {
     instance_type = "t2.micro"
     ami = "ami-05c424d59413a2876"
     tags = {
         Name = "App1Machine"    
     }
     key_name = "terraform-ec2"
 }

# resource "aws_instance" "App2" {
#     instance_type = "t2.micro"
#     ami = "ami-05c424d59413a2876"
#     tags = {
#         Name = "App2Machine"
#     }
#     key_name = "terraform-ec2"
# }

resource "aws_s3_bucket" "starbucket" {
   bucket = "mybucketokirjt"
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "Bucket1"
     Environment = "Test"
   }
}


variable "s3_bucket_name1" {
   type = "list"
   default = ["terr-ash-buc-1", "terr-ash-buc-1", "terr-ash-buc-1"]
}
resource "aws_s3_bucket" "henrys_bucket_jjuue" {
   count = "${length(var.s3_bucket_name1)}"
   bucket = "${var.s3_bucket_name1[count.index]}"
   acl = "private"
   versioning {
      enabled = true
   }
   force_destroy = "true"
}
