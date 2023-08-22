resource "aws_subnet" "private_subnets" {
 cidr_block = "10.0.240.0/24"
 vpc_id     = data.aws_vpc.vpc.id
}


resource "aws_subnet" "private_subnets1" {
 cidr_block = "10.0.241.0/24"
 vpc_id     = data.aws_vpc.vpc.id
}

resource "aws_subnet" "private_subnets2" {
 cidr_block = "10.0.242.0/24"
 vpc_id     = data.aws_vpc.vpc.id
}

resource "aws_subnet" "private_subnets3" {
 cidr_block = "10.0.243.0/24"
 vpc_id     = data.aws_vpc.vpc.id
}


resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id
}


resource "aws_route_table_association" "private" {
  count          = 4
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = data.aws_vpc.vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

}

resource "aws_lambda_function" "sample_lambda_func_lambda" {
              filename = "sample_lambda_func.zip"
}
            

resource "aws_lambda_function" "example" {
   function_name    = "lambda_function.py"
   role             = data.aws_iam_role.lambda.arn
   image_uri        = "3.devops.candidate.exam"
   handler          = "lambda_function.handler"
   runtime          = "python3.10"
   filename         = "sample_lambda_func.zip"
 

  vpc_config {
     subnet_ids         = aws_subnet.private_subnets.id
     security_group_ids = [aws_security_group.lambda_sg.id]
   }
 }
