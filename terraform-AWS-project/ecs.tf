#ECS cluster
resource "aws_ecs_cluster" "GameHighlightsECS" {
  name = "GameHighlightsECS"

}

#task definiftion for cluster

resource "aws_ecs_task_definition" "GameHighlights-TD" {
  family = "GameHighlights-TD"
  cpu = 256
  memory = 512
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = data.aws_iam_role.ecsTaskExecutionRole.arn


  container_definitions = jsonencode([
  {
    "name": "highlight-pipeline",
    "image": "${aws_ecr_repository.GameHighlightsECR.repository_url}:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": var.aws_region,
        "awslogs-group": "GameHighlightsLogs",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "environment": [
      {
        "name": "AWS_REGION",
        "value": tostring(var.aws_region)
      },
      {
        "name": "S3_BUCKET_NAME",
        "value": tostring(var.s3_bucket_name)
      },
      {
        "name": "MEDIACONVERT_ENDPOINT",
        "value": tostring(var.mediaconvert_endpoint)
      },
      {
        "name": "MEDIACONVERT_ROLE_ARN",
        "value": local.iam_role_arn.arn
      }
    ],
    "secrets": [
      {
        "name": "RAPIDAPI_KEY",
        "valueFrom": tostring(var.rapidapi_key)
      }
    ]
  }
  ])

  tags = {
    Name = "GameHighlights-TD"
  }
}

#ecs service
resource "aws_ecs_service" "GameHighlights-service" {
  name            = "GameHighlights-service"
  cluster         = aws_ecs_cluster.GameHighlightsECS.id
  task_definition = aws_ecs_task_definition.GameHighlights-TD.arn
  desired_count   = 1
  launch_type = "FARGATE"

  network_configuration {
  subnets = [aws_subnet.public_subnet.id]
  security_groups = [aws_security_group.GameHighlights-SG.id]
  assign_public_ip = true 
}
  tags = {
    Name = "GameHighlights-service"
  }
}