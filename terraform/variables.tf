## to change variable while running, use --var ami_id=xxx
variable "s3bucketname" {
  description = "The name of the S3 bucket created"
  type        = string
  default     = "lovelltest3"  #if no value defined at runtime, then will just use this default value. Runtime change: terraform plan --var s3bucketname=xxx
}

variable "env" {
  description = "The env of the S3 bucket"
  type        = string
  default     = "dev"
}

variable "department" {
  description = "The Department of the S3 bucket owner"
  type        = string
  default     = "DevOps"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0b72821e2f351e396"
}


variable "ec2_name" {
  description = "Name of EC2"
  type        = string
  default     = "ec2-lovell-from-tf-simple-node" # Change accordingly
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of EC2 Key Pair"
  type        = string
  default     = "lovell-useast1-13072024" # Change accordingly
}

variable "sg_name" {
  description = "Name of EC2 security group"
  type        = string
  default     = "lovell-ec2-allow-ssh-http-https" # Change accordingly
}

variable "vpc_name" {
  description = "Name of VPC to use"
  type        = string
  default     = "lovell-tf-vpc" # Change accordingly
}

variable "public_subnet_name1" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-public-subnet-us-east-1a" # Change accordingly
}

variable "public_subnet_name2" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-public-subnet-us-east-1b" # Change accordingly
}

variable "public_subnet_name3" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-public-subnet-us-east-1c" # Change accordingly
}

variable "private_subnet_name1" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-private-subnet-us-east-1a" # Change accordingly
}

variable "private_subnet_name2" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-private-subnet-us-east-1b" # Change accordingly
}

variable "private_subnet_name3" {
  description = "Name of subnet to use"
  type        = string
  default     = "lovell-tf-private-subnet-us-east-1c" # Change accordingly
}