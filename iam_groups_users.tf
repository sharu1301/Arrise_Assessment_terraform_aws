# Group for CLI access only
resource "aws_iam_group" "cli_access" {
  name = "group1"
}

resource "aws_iam_user" "engine" {
  name = "engine"
}

resource "aws_iam_user" "ci" {
  name = "ci"
}

resource "aws_iam_user_group_membership" "cli_users" {
  for_each = toset([aws_iam_user.engine.name, aws_iam_user.ci.name])
  
  user   = each.key
  groups = [aws_iam_group.cli_access.name]
}

resource "aws_iam_group_policy_attachment" "cli_access" {
  group      = aws_iam_group.cli_access.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Group for full access
resource "aws_iam_group" "full_access" {
  name = "group2"
}

resource "aws_iam_user" "john_doe" {
  name = "JohnDoe"
}

resource "aws_iam_user" "aboubacar_maina" {
  name = "AboubacarMaina"
}

resource "aws_iam_user_group_membership" "full_users" {
  for_each = toset([aws_iam_user.john_doe.name, aws_iam_user.aboubacar_maina.name])
  
  user   = each.key
  groups = [aws_iam_group.full_access.name]
}

resource "aws_iam_group_policy_attachment" "full_access" {
  group      = aws_iam_group.full_access.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}