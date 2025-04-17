# Administrative role without IAM access
resource "aws_iam_role" "roleA" {
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::277707134861:root"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "admin_no_iam" {
  name        = "AdminNoIAM"
  description = "Allows access to all AWS services except IAM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },
      {
        Effect    = "Deny"
        Action    = "iam:*"
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "roleA_policy" {
  role       = aws_iam_role.roleA.name
  policy_arn = aws_iam_policy.admin_no_iam.arn
}

# Service role that can assume roleC
resource "aws_iam_role" "roleB" {
  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "assume_roleC" {
  name        = "AssumeRoleC"
  description = "Allows assuming roleC"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = "arn:aws:iam::277707134861:role/roleC"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "roleB_policy" {
  role       = aws_iam_role.roleB.name
  policy_arn = aws_iam_policy.assume_roleC.arn
}