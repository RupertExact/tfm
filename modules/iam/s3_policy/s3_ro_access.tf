resource "aws_iam_policy" "main" {
  name = "${var.name}.s3_ro_access"
  path        = "/"
  description = "Policy allows access to all s3 buckets - List, Get"

  policy = "${data.aws_iam_policy_document.data.json}"
}


data "aws_iam_policy_document" "data" {
    statement {
        effect      = "Allow"
        actions     = ["s3:List*", ]
        resources   = ["${var.allowed_s3_resources}", ]
    }
    statement {
        effect      = "Allow"
        actions     = ["s3:Get*", ]
        resources   = ["${var.allowed_s3_resources}", ]
    }
}