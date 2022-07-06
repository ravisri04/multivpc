# multivpc

Quick Start sets up the following:

--> Three virtual private clouds (VPCs): management, production, and development. The VPCs are configured with subnets.

In the management VPC:
-----------------------

- An internet gateway, which serves as a highly available centralized point of egress for internet traffic.

- Public subnets that include managed network address translation (NAT) gateways to allow outbound internet access for resources in the private subnets.

- Private subnets for deploying your security and infrastructure controls.

- Flow logs for auditing.

In the production VPC:
------------------------

- Private subnets for deploying your production workloads.

- Flow logs for auditing.

In the development VPC:
------------------------

- Private subnets for deploying your development workloads.

- Flow logs for auditing.

--> AWS Transit Gateway for VPC-to-VPC communication and customer connectivity.

Planning:
==========

- These sites provide materials for learning how to design, deploy, and operate your infrastructure and applications on the AWS Cloud.

Regions:
==========

