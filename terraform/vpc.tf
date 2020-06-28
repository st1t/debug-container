variable "vpc_id" {
  type    = string
  default = "FIXME"
}

resource "aws_security_group" "container_debug" {
  name        = "container_debug"
  description = "container debug"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "container_debug"
  }
}
