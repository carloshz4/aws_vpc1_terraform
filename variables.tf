variable "aws_ip_cidr_range" {
  type        = "string"
  default     = "10.0.0.0/16"
  description = "IP CIDR range for AWS VPC"
}

variable "subnets" {
  type = "map"
  default = {
    subnet1 = "PublicSubnetTerraform"
    subnet2 = "PrivateSubnetTerraform"
  }
}

// Output variables
output "first_output" {
  value = "This is a value of output after execution"
}
