resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  target_id = var.target_id
  rule      = var.rule
  arn       = var.arn
  input     = var.input
  role_arn  = var.role_arn

  dynamic "run_command_targets" {
    for_each = length(keys(var.run_command_targets)) == 0 ? [] : [var.run_command_targets]
    content {
      key    = run_command_targets.value.key
      values = run_command_targets.value.values
    }
  }

  dynamic "ecs_target" {
    for_each = length(keys(var.ecs_target)) == 0 ? [] : [var.ecs_target]
    content {
      group               = lookup(ecs_target.value, "group", null)
      launch_type         = lookup(ecs_target.value, "launch_type", null)
      platform_version    = lookup(ecs_target.value, "platform_version", null)
      task_count          = lookup(ecs_target.value, "task_count", null)
      task_definition_arn = ecs_target.value.task_definition_arn

      dynamic "network_configuration" {
        for_each = lookup(ecs_target.value, "network_configuration", [])
        content {
          assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
          security_groups  = lookup(network_configuration.value, "security_groups", null)
          subnets          = network_configuration.value.subnets
        }
      }
    }
  }
}

