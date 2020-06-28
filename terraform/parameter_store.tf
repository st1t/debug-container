resource "aws_ssm_parameter" "hoge" {
  name        = "/debug_container/hoge"
  description = "The parameter description"
  type        = "SecureString"
  value       = "HOGEHOGE"
  overwrite   = true
}
