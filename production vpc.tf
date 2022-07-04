# Create 2nd VPC

resource "aws_vpc" "prod" {
  cidr_block       = "10.3.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Production VPC"
  }
}

# Create Private Subnet 1

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.3.0.0"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 1"
  }
}


# Create Private Subnet 2

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.3.0.16"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 2"
  }
}

# Create Flow logs

resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.prod.id
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example1"
}

#Attach transit gateway to vpc

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  subnet_ids         = [aws_subnet.private.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.prod.id
}
