  provider "aws" {
    access_key = "*"
    secret_key = "*"
    region = var.region
  }

  data "template_file" "policy" {
    template = file("iam/lambda-policy.json")
  }

  data "template_file" "role_policy" {
    template = file("iam/lambda-assume-policy.json")
  }

  resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          "Action" = "sts:AssumeRole",
          "Principal" = {
            "Service" = "lambda.amazonaws.com"
          },
          "Effect" = "Allow",
          "Sid" = ""
        }
      ]
  })
  }

  resource "aws_iam_role_policy" "lambda_policy" {
    name = "lambda_policy"
    role = aws_iam_role.lambda_role.id
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Sid"= "Stmt1637032896651"
          "Action"= [
            "logs:*",
          ]
          "Effect"= "Allow"
          "Resource"= "*"
        }
      ]
    })
  }

  locals {

    greet_lambda_location = "outputs/greet_lambda.zip"
  }

  # Archive a single file.
  data "archive_file" "greet_lambda" {
    type        = "zip"
    source_file = "greet_lambda.py"
    output_path = "local.greet_lambda_location"
  }

  resource "aws_lambda_function" "test_lambda" {
    filename      = "local.greet_lambda_location"
    function_name = "lambda_handler"
    role          = aws_iam_role.lambda_role.arn
    handler       = "greet_lambda.lambda_handler"

    # The filebase64sha256() function is available in Terraform 0.11.12 and later
    # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
    # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
    source_code_hash = filebase64sha256("local.greet_lambda_location")

    runtime = "python3.7"

  }

