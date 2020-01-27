variable "web-ec2-ami" {
  description = "web ec2 ami id"
  default = "ami-0f27edf319b4c6541"
}

variable "web-ec2-type" {
  description = "proxy ec2 ami instance type"
  default = "t2.micro"
}

variable "web-ec2-subnets" {
  description = "web subnets"

  type="list"
  default = ["10.0.30.0/24"]
}

variable "web-eip" {
  description = "web eip"
  default = "eipalloc-0d71bc935c36df234"
}

variable "web-az" {
  description = "web availability zones"

  type="list"
  default = ["ap-northeast-1a"]
}
