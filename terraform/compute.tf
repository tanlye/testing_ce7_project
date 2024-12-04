# This code block allows us to create an ec2 instance with hardcoded values
# resource "aws_instance" "sample_ec2_hardcoded" {
#   ami           = "ami-0b72821e2f351e396"
#   instance_type = "t2.micro"
#   key_name      = "lovell-useast1-13072024" # change to your own keypair name
#   subnet_id     = "subnet-00c9465dee15fbd7a" # change to your own vpc subnet id
#   associate_public_ip_address = true
#   vpc_security_group_ids = [aws_security_group.ec2_sg.id]

#   tags = {
#     Name = "lovell-webserver-terraform"
#   }
# }

data "aws_ami" "ami_id" {
  most_recent      = true
 # name_regex       = "al2023-ami-2023.*"
  owners           = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



# This code block allows us to create an ec2 instance with the use of variables
# To overwrite any one particular variable, we can pass the variable at runtime during terraform apply step
# e.g. terraform apply --var ec2_name="my-webserver"
resource "aws_instance" "sample_ec2_variables" {
  ami                         = data.aws_ami.ami_id.id   #var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
  #vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.ec2_name
  }
}