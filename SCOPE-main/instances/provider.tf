terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}
/* this file is  Like a settings file where you specify which cloud service (like AWS, Google Cloud, or Azure) you want to use and how to connect to it, effectively telling Terraform,
 "Here's where I want to build and manage my stuff, and here's the key to get in."
#It defines the source and version of the provider, ensuring that Terraform uses the correct version of the AWS provider.
*/

provider "aws" {
  region = var.region
}
# It typically includes necessary information like the AWS region where resources will be created.

