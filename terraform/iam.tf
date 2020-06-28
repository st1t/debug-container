resource "aws_iam_role" "fargate-execution" {
  name = "fargate-execution"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudwatchlogsfullaccess-to-fargate-execution" {
  role       = aws_iam_role.fargate-execution.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_policy" "read-parameter-store" {
  name        = "read-parameter-store"
  path        = "/"
  description = "For fargate execution role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": "ssm:GetParameters",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "read-parameter-store" {
  role       = aws_iam_role.fargate-execution.name
  policy_arn = aws_iam_policy.read-parameter-store.arn
}

resource "aws_iam_role" "task-execution" {
  name = "task-execution"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
 ]
}
EOF
}

# for ssm-agent
resource "aws_iam_policy" "run-command" {
  name        = "run-command"
  path        = "/"
  description = "For ssm-agent"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "iam:GetRole",
            "iam:PassRole"
        ],
        "Resource": "arn:aws:iam::995230650869:role/service-role/AmazonEC2RunCommandRoleForManagedInstances"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm-agent-run-command-to-task-execution" {
  role       = aws_iam_role.task-execution.name
  policy_arn = aws_iam_policy.run-command.arn
}

resource "aws_iam_role_policy_attachment" "amazonssmmanagedinstancecore-to-task-execution" {
  role       = aws_iam_role.task-execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "amazonssmdirectoryserviceaccess-to-task-execution" {
  role       = aws_iam_role.task-execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

resource "aws_iam_role_policy_attachment" "amazonssmautomationrole-to-task-execution" {
  role       = aws_iam_role.task-execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
}


