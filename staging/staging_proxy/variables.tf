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
  default = "arn:aws:acm:us-east-1:663941361441:certificate/8b114be8-0f6d-4533-b7ee-6e37e9025251"
}

variable "acm-tokyo-arn" {
  description = "acm certificate arn"
  default = "arn:aws:acm:ap-northeast-1:663941361441:certificate/fd08b648-5593-4ef9-85bc-d77be2e019d4"
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
