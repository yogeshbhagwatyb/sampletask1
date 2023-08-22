#S3 Bucket: "3.devops.candidate.exam"
#Region: "ap-south-1"
#Key: "s3/yogeshbhagwat"

terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    key    = "yogeshbhagwat"
    region = "ap-south-1"
  }
}
