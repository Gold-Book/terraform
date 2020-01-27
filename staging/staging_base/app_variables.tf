variable "app-domain" {
  description = "exampleapp app domain"
  default = "ec.exampleapp.com"
}

variable "app-ec2-ami" {
  description = "app ec2 ami id"
  default = "ami-0354ef6a6ae8e995d"
}

variable "app-ec2-type" {
  description = "app ec2 ami instance type"
  default = "t2.micro"
}

variable "app-ec2-subnets" {
  description = "application subnets"

  type="list"
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "app-az" {
  description = "application availability zones"

  type="list"
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}
