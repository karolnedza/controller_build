Steps on fresh Ubuntu Instance:

## Update the package list

$ sudo apt update -y

## Install terraform

$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
$ sudo apt install unzip -y
$ unzip terraform_0.12.26_linux_amd64.zip
$ sudo mv terraform /bin/
$ rm terraform_0.12.26_linux_amd64.zip
$ terraform -v
Terraform v0.12.26

## Git should be already pre-installed on Ubuntu. If it isn't

$ sudo apt install git

## Install awscli

$ sudo apt install awscli
$ aws --version

aws-cli/1.14.44 Python/3.6.9 Linux/4.15.0-1065-aws botocore/1.8.48


## Clone repository to a directory

$ git clone https://github.com/karolnedza/controller_build.git .

## Add your AWS Access-Key and Secret-Key

$ aws configure
AWS Access Key ID [****************S3Q3]:
AWS Secret Access Key [****************vmrW]:
Default region name [us-east-1]:
Default output format [None]:

## Run terraform

$ terraform init

$ terraform apply
