provider "aws" {
  region = "us-east-1" # Change as needed
  # Use profile or explicit credentials for account 1111111111
}

resource "aws_iam_role" "roleC" {
  name = "roleC"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::277707134861:role/roleB"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccessToTestBucket"
  description = "Full access to aws-test-bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = [
          "arn:aws:s3:::aws-test-bucket",
          "arn:aws:s3:::aws-test-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "roleC_policy" {
  role       = aws_iam_role.roleC.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}
