provider "aws" {
  region = "us-east-1"
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  instances = [
    {
      instance_type = "t2.micro"
      volume_type   = "gp2"
      volume_size   = 8
      key_pair      = "key1"
    },
    {
      instance_type = "t2.small"
      volume_type   = "gp3"
      volume_size   = 20
      key_pair      = "key2"
    },
    {
      instance_type = "t2.small"
      volume_type   = "gp3"
      volume_size   = 10
      key_pair      = "key3"
    },
    {
      instance_type = "t2.medium"
      volume_type   = "gp3"
      volume_size   = 30
      key_pair      = "key4"
    },
    {
      instance_type = "t2.medium"
      volume_type   = "gp2"
      volume_size   = 15
      key_pair      = "key5"
    }
  ]
}