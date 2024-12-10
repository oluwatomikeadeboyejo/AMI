variable "ami_name" {
  description = "The name for the AMI to be created."
  default     = "ami-scopeinfotech"
}

variable "ami_regions" {
  description = "List of AWS regions where the AMI will be available."
  type        = list(string)
  default     = ["us-east-1"]
}

variable "aws_accounts" {
  description = "List of AWS account IDs that can access the AMI."
  type        = list(string)
  default     = ["XXXXX"]
}

variable "aws_instance_type" {
  description = "The type of AWS instance to be used for building the AMI."
  default     = "t3a.medium"
}

variable "aws_region" {
  description = "The AWS region where the Packer build will run."
  default     = "us-east-1"
}

variable "aws_source_ami" {
  description = "The pattern of the AMI that will be used for the golden image"
  default     = "amzn2-ami-kernel-*-hvm-2.0.*-x86_64-gp2"
}

variable "ami_owners" {
  description = "List of owner IDs for the sourced AMI."
  type        = list(string)
  default     = ["xxxx", "amazon"]
}

