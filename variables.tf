########################################## Cloud Watch Event Target ##############################################

variable "target_id" {
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
}

variable "rule" {
  description = "The name of the rule you want to add targets to."
}

variable "arn" {
  description = "The Amazon Resource Name (ARN) associated of the target."
}

variable "role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
}

variable "input" {
  description = "Valid JSON text passed to the target."
  default     = null
}

variable "run_command_targets" {
  description = "Parameters used when you are using the rule to invoke Amazon EC2 Run Command."
  type        = any
  default     = {}
}

variable "ecs_target" {
  description = "Parameters used when you are using the rule to invoke Amazon ECS Task."
  type        = any
  default     = {}
}