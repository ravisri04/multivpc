#Attach transit gateway to vpc

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {

  transit_gateway_cidr_blocks = ["10.99.0.0/24"]

  # When "true" there is no need for RAM resources if using multiple AWS accounts
  enable_auto_accept_shared_attachments = true

  # When "true", allows service discovery through IGMP
  enable_mutlicast_support = false

  vpc_attachments = {
    vpc1 = {
      vpc_id       = aws_vpc.main.id
      subnet_ids   = aws_vpc.private_subnets
      dns_support  = true
      ipv6_support = true

      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false

      tgw_routes = [
        {
          destination_cidr_block = "10.2.0.0/16"
        },
        {
          blackhole              = true
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    },
    vpc2 = {
      vpc_id     = aws_vpc.prod.id
      subnet_ids = aws_vpc.private_subnets

      tgw_routes = [
        {
          destination_cidr_block = "10.3.0.0/16"
        },
        {
          blackhole              = true
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    },
  }
  vpc3 = {
      vpc_id     = aws_vpc.prod.id
      subnet_ids = aws_vpc.private_subnets

      tgw_routes = [
        {
          destination_cidr_block = "10.4.0.0/16"
        },
        {
          blackhole              = true
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    },
  }

#AWS transit gateway attach to aws site to site vpn

data "aws_transit_gateway_vpn_attachment" "tgw_site" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpn_connection_id  = aws_vpn_connection.tgw_site.id
}

data "aws_ec2_transit_gateway_vpn_attachment" "test" {
  filter {
    name   = "resource-id"
    values = ["some-resource"]
  }
}

#AWS transit gateway attach to aws connect direct

data "aws_ec2_transit_gateway_dx_gateway_attachment" "tgw_cd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  dx_gateway_id      = aws_dx_gateway.tgw_cd.id
}