# packer {
#   required_plugins {
#     amazon = {
#       version = ">= 1.0.0"
#       source  = "github.com/hashicorp/amazon"
#     }
#     }
#   }

packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}


locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

data "amazon-ami" "source_ami" {
  filters = {
    name = var.aws_source_ami
    root-device-type = "ebs"
  }
  most_recent = true
  owners      = var.ami_owners
  region      = var.aws_region
}

source "amazon-ebs" "amazon_ebs" {
  ami_name = "${var.ami_name}-${local.timestamp}" 
  ami_regions = "${var.ami_regions}"               
  ami_users = "${var.aws_accounts}"                
  snapshot_users = "${var.aws_accounts}"          
  encrypt_boot = false                           
  instance_type = "${var.aws_instance_type}"       
  # launch_block_device_mappings {                   
  #   delete_on_termination = true                  
  #   device_name = "/dev/xvda"                      
  #   encrypted = false                              
  #   volume_size = 10                             
  #   volume_type = "gp2"                            
  # }
  region = "${var.aws_region}"                   
  source_ami = "${data.amazon-ami.source_ami.id}" 
  ssh_pty = true                                
  ssh_timeout = "5m"                            
  ssh_username = "ec2-user"                       

    run_tags = {
    "Name" = "Packer_Instance" 
  }
}


build {
  sources = ["source.amazon-ebs.amazon_ebs"]

  # provisioner "ansible" {
  #   playbook_file = "./playbook.yml"
  #   extra_arguments = ["-vvv"]
  # }

  provisioner "shell" {
    script = "./config.sh"
  }
}


# build {
#   sources = ["source.amazon-ebs.amazon_ebs"]

#   provisioner "ansible" {
#     playbook_file = "./playbook.yml"

#   }

#   provisioner "shell" {
#     script = "./config.sh"
#   }
# }

