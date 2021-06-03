provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    alias  = "west"
    region = "us-west-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

module "gitawsdemo" {
    source        = "./modules"
    name          = "demo-gitaws"
    vpc_id        = aws_vpc.main.id
    cidr_block    = cidrsubnet(aws_vpc.main.cidr_block, 4, 1)
    ami           = "ami-003634241a8fcdec0"
    instance_type = "t2.micro"
}