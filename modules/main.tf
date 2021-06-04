#Terraform, Gitlab and AWS
#1 Create a terraform module template that creates:
#	1. VPC with CIDR 10.0.0.0/16
#	2. 2 subnets (public) with CIDR 10.0.1.0/24 and 10.0.2.0/24
#	3. An autoscaling group with Amazon Linux 2 instance (t3.nano) with a min of 2 instances and max of 3
#	4. Create a bucket to store your terraform state

#2  Use Gitlab to create a CI/CD pipeline that will test the and deploy the infrastructure through AWS


provider "aws" {
    region = "us-east-1"
}

#1 Create a VPC with CIDR 10.0.0.0/16
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"


    tags = {
        Name = "Main VPC"
    }
}

#2 Two Public Subnets 10.0.1.0/24 and 10.0.2.0/24
resource "aws_subnet" "Public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public-Subnet 1"
  }
}

resource "aws_subnet" "Public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public-Subnet 2"
  }
}
#3 Create an autoscaling group with Amazon Linux 2 instance (t3.nano) with a min of 2 instances and max of 3



resource "aws_launch_configuration" "launch_configuration" {
  name = "demo_launch_configuration"
  image_id = "ami-0d5eff06f840b45e9"
  instance_type = "t3.nano"
}

resource "aws_autoscaling_group" "aws_asg_config" {
  name = "demo_autoscaling_group"
  min_size = 2
  max_size = 3
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration.launch_configuration.name
  lifecycle {
    create_before_destroy = true
  }
}

#4 Create an S3 Bucket to store our terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
