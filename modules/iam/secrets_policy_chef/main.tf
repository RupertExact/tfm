resource "aws_iam_policy" "main" {
  name = "${var.name}.secrets_access"
  path        = "/"
  description = "Policy allows access to secure secrets stored in SSM Parameters"

  policy = "${data.aws_iam_policy_document.data.json}"
}

data "aws_iam_policy_document" "data" {
    statement {
        effect      = "Allow"
        actions     = [ "ssm:DescribeParameters", ]
        resources   = [ "*", ]
    }
    statement {
        effect      = "Allow"
        actions     = [ "ssm:*"]
        resources   = [ "arn:aws:ssm:${var.aws_region}:${var.aws_acc_id}:parameter/${var.environment}/chef/*", ]
    }

    statement {
        effect      = "Allow"
        actions     = [ "ssm:*", ]
        resources   = [ "arn:aws:ssm:${var.aws_region}:${var.aws_acc_id}:parameter/chef/*", ]
    }

    statement {
        effect      = "Allow"
        actions     = [ "kms:Decrypt", ]
        resources   = [ "arn:aws:kms:${var.aws_region}:${var.aws_acc_id}:alias/aws/ssm", ]
        
    }
}

# use the following in the decrypt statement when using a Custom KMS key
# resources   = [ "arn:aws:kms:${var.aws_region}:${var.aws_acc_id}:key/<key-id>", ]

// Important: these rules conflict with the rules set out by the ec2 default role. 
// Default role allows access to all parameters. 
// This could be resolved by having separate CMK keys for each server type. Sounds a bit excessive.

