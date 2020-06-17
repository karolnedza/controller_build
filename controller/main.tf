####### Terraform Provider

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "aws_account" {}


### AWS VPC

resource "aws_vpc" "avtx_ctrl_vpc" {

cidr_block       = "10.255.0.0/20"

tags = {
  Name = "controller_vpc"
  }
}

### VPC Internet GW

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.avtx_ctrl_vpc.id
}

###  VPC Subnet

resource "aws_subnet" "avtx_ctrl_subnet" {
  vpc_id     = aws_vpc.avtx_ctrl_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.255.0.0/28"

  tags = {
    Name = "controller_subnet"
  }
}


####  VPC Route-Table

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.avtx_ctrl_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

##### SSH-Key

resource "aws_key_pair" "avtx_ctrl_key" {
  key_name   = "avtx-ctrl-key"
  public_key = file("ctrl_key.pub")
}


#### IAM Role

module "avtx_iam_role"{
  source = "./aviatrix-controller-iam-roles"
}

#### Controller Build

module "avtx_controller_instance" {
  source = "./aviatrix-controller-build"
  vpc     = aws_vpc.avtx_ctrl_vpc.id
  subnet  = aws_subnet.avtx_ctrl_subnet.id
  keypair = aws_key_pair.avtx_ctrl_key.key_name
  ec2role = module.avtx_iam_role.aviatrix-role-ec2-name
  termination_protection = false
}


####### Outputs

output "aws_account" {
  value = data.aws_caller_identity.aws_account.account_id
}

output "controller_private_ip" {
  value = module.avtx_controller_instance.private_ip
}


output "controller_public_ip" {
  value = module.avtx_controller_instance.public_ip
}
