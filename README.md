# Terraform Module: terraform-module-aws-cloudwatch-events-target

## General

This module can be used to deploy a **_CloudWatch Event Target_**

---

## Prerequisites

This module needs **_Terraform 0.12.18_** or newer.
You can download the latest Terraform version from [here](https://www.terraform.io/downloads.html).

---

## Features

Below are the resources that are launched by this module

* **_CloudWatch Event Target_**


---

## Usage

## Using this repo

To use this module, add the following call to your code:

* **_Exmaple Target : CodeBuild_**

```tf
module "<layer>_cloudwatch_event_target_<AccountID>" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-events-target.git?ref=master"

  providers = {
    aws = aws.services
  }
  
  arn       = "arn:aws:codebuild:eu-central-1:${var.account_id}:project/code-build-ami-builder"
  rule      = "arn:aws:events:eu-central-1:${var.account_id}:rule/event_rule"
  role_arn  = "arn:aws:iam::${var.account_id}:role/service-role/iam-role-ami-builder-cloudwatch-events"
  target_id = "target-id-code-build-ami-builder"
}
```

* **_Exmaple Target : ECS_**

```tf
module "<layer>_cloudwatch_event_target_<AccountID>" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-events-target.git?ref=master"

  providers = {
    aws = aws.services
  }
  
  arn        = "arn:aws:ecs:eu-central-1:${var.account_id}:cluster/ecs-services"
  rule       = "arn:aws:events:eu-central-1:${var.account_id}:rule/event_rule"
  role_arn   = "arn:aws:iam::${var.account_id}:role/service-role/iam-role-ami-builder-cloudwatch-events"
  target_id  = "target-id-ecs"
  ecs_target = {
    task_count          = 1
    task_definition_arn = "arn:aws:ecs:eu-central-1:${var.account_id}:task-definition/ecs-task-definition:51"
  }
}
```

* **_Exmaple Target : RUN Command_**

```tf
module "<layer>_cloudwatch_event_target_<AccountID>" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-events-target.git?ref=master"

  providers = {
    aws = aws.services
  }
  
  arn                 = "arn:aws:ssm:${var.region}::document/AWS-RunShellScript"
  rule                = "arn:aws:events:eu-central-1:${var.account_id}:rule/event_rule"
  role_arn            = "arn:aws:iam::${var.account_id}:role/service-role/iam-role-ami-builder-cloudwatch-events"
  target_id           = "target-id-run-command"
  input               = "{\"commands\":[\"halt\"]}"
  run_command_targets = {
    key    = "tag:Terminate"
    values = ["midnight"]
  }
}
```

---

## Inputs

The variables required in order for the module to be successfully called from the deployment repository are the following:


|**_Variable_** | **_Description_** | **_Type_** | **_Argument Status_** |
|:----|:----|-----:|-----:|
| **_target\_id_** | _The unique target assignment ID_ | _string_ | **_Required_** |
| **_rule_** | _The name of the rule you want to add targets to_ | _string_ | **_Required_** |
| **_arn_** | _The Amazon Resource Name (ARN) associated of the target_ | _string_ | **_Required_** |
| **_role\_arn_** | _The ARN associated with the role that is used for target invocation_ | _string_ | **_Required_** |
| **_input_** | _Valid JSON text passed to the target_ | _string_ | **_Optional_** |
| **_run\_command\_targets_** | _Parameters used when you are using the rule to invoke Amazon EC2 Run Command_ | _any_ | **_Optional_** |
| **_ecs\_target_** | _Parameters used when you are using the rule to invoke Amazon ECS Task_ | _any_ | **_Optional_** |



---



## Outputs

### General
This module has the following outputs:

* **_None_**



### Usage
In order for the variables to be accessed at module level please use the syntax below:
```tf
module.<module_name>.<output_variable_name>

```

If an output variable needs to be exposed on root level in order to be accessed through terraform state file follow the steps below:

- Include the syntax above in the layer outputs.tf terraform file.
- The output variable is able to be accessed through terraform state file using the syntax below:
```tf
"${data.terraform_remote_state.<layer_name>.<output_variable_name>}"
```
---


### Known Issues / Limitations

### Planned changes

* **_None_**


---

## Authors

Deployed and managed by **_Nitin Das_**