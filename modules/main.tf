resource "aws_subnet" "gitawsdemo" {
    vpc_id     = var.vpc_id
    cidr_block = var.cidr_block
}

resource "aws_instance" "gitawsdemo" {
    ami           = var.ami
    instance_type = var.instance_type
    subnet_id     = aws_subnet.webserver.id

    tags = {
        Name = var.name
    }
}
