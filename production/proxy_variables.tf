variable "proxy-ec2-ami" {
  description = "proxy ec2 ami id"
  default = "ami-02e223ec85fff58a8"
}

variable "proxy-ec2-type" {
  description = "proxy ec2 ami instance type"
  default = "t2.micro"
}

variable "proxy-ec2-subnets" {
  description = "proxy subnets"

  type="list"
  default = ["10.0.4.0/24"]
}

variable "proxy-eip" {
  description = "proxy eip"
  default = "" // todo eip取得
}

variable "proxy-az" {
  description = "proxy availability zones"

  type="list"
  default = ["ap-northeast-1a"]
}
