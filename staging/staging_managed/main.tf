provider "aws" {
    access_key = "${var.access-key}"
    secret_key = "${var.secret-key}"
    region = "${var.region}"
    skip_credentials_validation = true
}

locals {
  app-prefix = "${var.stage}-${var.project}-app"
  web-prefix = "${var.stage}-${var.project}-web"
  admin-prefix = "${var.stage}-${var.project}-admin"
  public-prefix = "${var.stage}-${var.project}-public"
  managed-prefix = "${var.stage}-${var.project}-managed"
  proxy-prefix = "${var.stage}-${var.project}-proxy"

  public-bucket = "${var.stage}-${var.public-bucket}"
  public-bucket-arn = "arn:aws:s3:::${var.stage}-${var.public-bucket}"
  public-bucket-fqdn = "${var.stage}-${var.public-bucket}.s3.amazonaws.com"

  private-bucket = "${var.stage}-${var.private-bucket}"

  private-logs-bucket = "${var.stage}-${var.private-logs-bucket}"
  private-logs-bucket-arn = "arn:aws:s3:::${var.stage}-${var.private-logs-bucket}"
  private-logs-bucket-fqdn = "${var.stage}-${var.private-logs-bucket}.s3.amazonaws.com"

  ec2-ssh-key = "${var.stage}-exampleapp"
}
