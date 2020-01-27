variable "admin-ec2-num" {
  description = "admin ec2 required num"
  default = 1
}

variable "admin-ec2-ami" {
  description = "admin ec2 ami id"
  default = "ami-0354ef6a6ae8e995d"
}

variable "admin-ec2-type" {
  description = "admin ec2 ami instance type"
  default = "t2.micro"
}

variable "admin-ec2-subnets" {
  description = "application subnets"

  type="list"
  default = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "admin-az" {
  description = "application availability zones"

  type="list"
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}
