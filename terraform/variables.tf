variable "aws_region" {
  default = "us-east-1"
}

# S3 Bucket Variables
variable "bucket_prefix" {
  type    = string
  default = "wijha-"
}

variable "versioning" {
  type    = string
  default = "Enabled"
}

