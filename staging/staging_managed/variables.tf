variable "access-key" {
  description = "aws access key"
  default = ""
}

variable "secret-key" {
  description = "aws secret key"
  default = ""
}

variable "region" {
  description = "aws region"
  default = "ap-northeast-1"
}

variable "project" {
  description = "project name"
  default = "apte"
}

variable "stage" {
  description = "target stage"
  default = "stg"
}

variable "acm-arn" {
  description = "acm certificate arn"
  default = "arn acm"
}

variable "acm-tokyo-arn" {
  description = "acm certificate arn"
  default = "tokyo acm"
}

variable "private-bucket" {
  description = "prefix is ​​added to the private bucket"
  default = "exampleapp-private"
}

variable "private-logs-bucket" {
  description = "prefix is ​​added to the private log bucket"
  default = "exampleapp-private-logs"
}

variable "public-bucket" {
  description = "prefix is ​​added to the public bucket"
  default = "exampleapp-public"
}
