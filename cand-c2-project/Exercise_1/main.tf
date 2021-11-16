# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "*"
  secret_key = "*"
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "UdacityT2_1" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
}

resource "aws_instance" "UdacityT2_2" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
}
resource "aws_instance" "UdacityT2_3" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
}

resource "aws_instance" "UdacityT2_4" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
}
# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "UdacityM4_1" {
  ami = "ami-02e136e904f3da870"
  instance_type = "m4.large"
}

resource "aws_instance" "UdacityM4_2" {
  ami = "ami-02e136e904f3da870"
  instance_type = "m4.large"
}