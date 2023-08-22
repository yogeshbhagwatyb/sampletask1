data "aws_nat_gateway" "nat" {
  id = "nat-0d688bbff8a47b274"
}

data "aws_vpc" "vpc" {
  id = "vpc-00bf0d10a6a41600c"
  #cidr_block = 10.0.254.0/24
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}
