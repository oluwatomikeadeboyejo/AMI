variable "region"{
  description = "The region Terraform deploys your instance"
  default     = "us-east-1"
}

# It will deploy in the automation account. 

variable "vpc_id"{
    default="vpc-0625cf9a680f3301f"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-0a0a9b5b883ff93b7",
    "subnet-0055ccfc933d1177a",
   ]
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ses_key.pub"
}
