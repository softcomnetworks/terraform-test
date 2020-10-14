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
    region = "eu-west2"
    
}

resource "aws_instance" "App1" {
    instance_type = "t2.micro"
    ami = "ami-05c424d59413a2876"
    key_name = "terraform-test-machines"
    
}