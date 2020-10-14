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

resource "aws_instance" "App1" {
    instance_type = "t2.micro"
    ami = "ami-05c424d59413a2876"
    tags = {
        Name = "App1Machine"    
    }
    key_name = "terraform-ec2"
}

resource "aws_instance" "App2" {
    instance_type = "t2.micro"
    ami = "ami-05c424d59413a2876"
    tags = {
        Name = "App2Machine"
    }
    key_name = "terrraform-ec2"
}
