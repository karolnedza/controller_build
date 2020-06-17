data "terraform_remote_state" "controller" {
  backend = "local"
  config = {
    path = "../terraform.tfstate"
  }
}


provider "aviatrix" {
  username = "admin"
  controller_ip = data.terraform_remote_state.controller.outputs.controller_public_ip
  password = xxxxxxx
}

# 
# resource "aviatrix_vpc" "aws_vpc" {
#   cloud_type           = 1
#   account_name         = "aws-account"
#   region               = "us-west-1"
#   name                 = "aws-vpc"
#   cidr                 = "10.0.0.0/16"
#   aviatrix_transit_vpc = false
#   aviatrix_firenet_vpc = false
# }
