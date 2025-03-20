#ecs log group
  resource "aws_cloudwatch_log_group" "GameHighlightsLogs" {
  name = "GameHighlightsLogs"
  retention_in_days = 7
}