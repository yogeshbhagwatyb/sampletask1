resource "aws_subnet" "private_subnets" {
 cidr_block = "10.0.240.0/24"
 vpc_id     = data.aws_vpc.vpc.id
}



resource "aws_route_table" "route_table_new_task" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
}


resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.route_table_new_task.id
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


data "archive_file" "task_function" {
  type             = "zip"
  source_file      = "lambda_function.py"
  output_path      = "mylf.zip"
}

            

resource "aws_lambda_function" "yogesh_function" {
   function_name    = "yogesh_function"
   role             = data.aws_iam_role.lambda.arn
   handler          = "lambda_function.lambda_handler"
   runtime          = "python3.8"
   filename         = "mylf.zip"
 

  vpc_config {
     subnet_ids          = aws_subnet.private_subnets.id
     security_group_ids = aws_security_group.lambda_sg.id
   }
 }
