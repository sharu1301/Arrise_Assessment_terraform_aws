variable "instances" {
  description = "List of EC2 instance configurations"
  type = list(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_pair      = string
  }))
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  count = length(var.instances)

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instances[count.index].instance_type
  key_name      = var.instances[count.index].key_pair

  root_block_device {
    volume_type = var.instances[count.index].volume_type
    volume_size = var.instances[count.index].volume_size
    throughput  = var.instances[count.index].volume_type == "gp3" ? 125 : null
  }

  tags = {
    Name = "instance-${count.index + 1}"
  }
}