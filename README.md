# AWS VPC creation via Terraform - Scenario 1

This Repo contains the diagram, Terraform code and relevant information to build an AWS VPC along with these elements:

- Security Group
- Subnets (Public and Private)
- IGW
- Route Table
- EC2 Instances


## Diagram
This is the diagram of the mini infraestructure created for this scenario:

![Diagram](https://github.com/carloshz4/aws_vpc1_terraform/blob/master/VPC1.jpg)


Note diagram was create with [draw.io](https://www.draw.io/) which is a handy and free tool to create and edit these kind of diagrams.

This [link](https://www.draw.io/?libs=aws2) loads directly the aws libraries.
And the desktop version can be downloaded [here](https://github.com/jgraph/drawio-desktop/releases/tag/v12.1.7)

## How to run it
Clone this repo and install Terraform. Then create the connections.tf (providers) file so that you can connect to your aws account (you need a priviliged user with the access keys). Then init, validate, plan and deploy this infra with the commands:
```
terraform init
terraform validate
terraform plan
terraform apply
```

## Important notes

Your connections file will look similar to:

```
provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

```

Note these are not real values. Use your own region and keys


> Enjoy, make it different, make it better, and please share suggestions, ideas if you have.
