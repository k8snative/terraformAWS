variable "vpc_name" {
  description = "Enter a name for the VPC"
}

variable "vpc_cidr" {
  description = "Enter the CIDR block for the VPC (e.g., 192.168.0.0/16)"
}

variable "public_subnet1_cidr" {
  description = "Enter Public Subnet 1"
}

variable "public_subnet2_cidr" {
  description = "Enter Public Subnet 2"
}

variable "public_subnet3_cidr" {
  description = "Enter Public Subnet 3"
}

variable "private_subnet1_cidr" {
  description = "Enter Private Subnet 1"
}

variable "private_subnet2_cidr" {
  description = "Enter Private Subnet 2"
}

variable "private_subnet3_cidr" {
  description = "Enter Private Subnet 3"
}
