output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = module.ec2_instances.instance_ids
}

output "iam_users" {
  description = "Created IAM users"
  value = {
    cli_users  = [aws_iam_user.engine.name, aws_iam_user.ci.name]
    full_users = [aws_iam_user.john_doe.name, aws_iam_user.aboubacar_maina.name]
  }
}

output "iam_roles" {
  description = "Created IAM roles"
  value = [aws_iam_role.roleA.name, aws_iam_role.roleB.name]
}