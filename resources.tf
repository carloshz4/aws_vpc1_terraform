resource "aws_vpc" "env_example" {
  cidr_block           = "${var.aws_ip_cidr_range}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.env_example.id}"

  tags = {
    Name = "terraform_igw"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block        = "${cidrsubnet(aws_vpc.env_example.cidr_block, 8, 1)}"
  vpc_id            = "${aws_vpc.env_example.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.subnets["subnet1"]}"
  }
}

resource "aws_subnet" "subnet2" {
  cidr_block        = "${cidrsubnet(aws_vpc.env_example.cidr_block, 8, 2)}"
  vpc_id            = "${aws_vpc.env_example.id}"
  availability_zone = "us-east-2b"
  tags = {
    Name = "${var.subnets["subnet2"]}"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.env_example.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "terraform_public_rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_security_group" "SG_terraform" {
  vpc_id = "${aws_vpc.env_example.id}"
  name = "SG_terraform"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22 
    to_port   = 22 
    protocol  = "tcp"
  }
  tags = {
    Name = "PublicSG_terraform"
  }

}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "PublicEC2_terraform" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${aws_security_group.SG_terraform.id}"]
  associate_public_ip_address = true
  key_name = "test-1-Nov-2018"
  tags = {
    Name = "PublicEC2_terraform"
  }

  subnet_id = "${aws_subnet.subnet1.id}"
}


resource "aws_instance" "PrivateEC2_terraform" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  tags = {
    Name = "PrivateEC2_terraform"
  }

  subnet_id = "${aws_subnet.subnet2.id}"
}
