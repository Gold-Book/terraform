variable "managed-ec2-ami" {
  description = "managed ec2 ami id"
  default = "ami-0f9ecdf60efe3773b"
}

variable "managed-ec2-type" {
  description = "managed ec2 ami instance type"
  default = "t2.micro"
}

variable "managed-ec2-subnets" {
  description = "managed subnets"

  type="list"
  default = ["10.0.40.0/24"]
}

variable "managed-eip" {
  description = "managed eip"
  default = "eipalloc-0ece85cdf70c157a3"
}

variable "managed-az" {
  description = "managed availability zones"

  type="list"
  default = ["ap-northeast-1a"]
}
