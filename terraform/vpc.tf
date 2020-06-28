variable "vpc_id" {
  type    = string
  default = "FIXME"
}

resource "aws_security_group" "container_debug" {
  name        = "container_debug"
  description = "container debug"
  vpc_id      = var.vpc_id

  tags = {
    Name = "container_debug"
  }
}
