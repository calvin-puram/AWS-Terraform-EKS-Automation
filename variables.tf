variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
  type = string
}

variable "private_subnets_cidr_blocks" {
  description = "CIDR block for the private subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type = list
}

variable "public_subnets_cidr_blocks" {
  description = "CIDR block for the public subnet"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  type = list
}