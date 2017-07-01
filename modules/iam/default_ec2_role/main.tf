# Role to allow access to S3 buckets that contain VM setup and config files

resource "aws_iam_role" "defaultEc2Role" {
  name = "${var.name}.ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "defaultInstProfile" {
  name = "${var.name}.inst_profile"
  role = "${aws_iam_role.defaultEc2Role.name}"
}
/*
resource "aws_iam_role_policy" "s3AccessPolicy" {
  name = "${var.name}.s3AccessPolicy"
  role = "${aws_iam_role.defaultEc2Role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:List*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:Get*"],
      "Resource": ["*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "addEc2SecondaryIpPolicy" {
    name = "${var.name}.ec2SecondaryIpPolicy"
    role = "${aws_iam_role.defaultEc2Role.id}"
    
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "ec2:AssignPrivateIpAddresses",
                "ec2:DescribeNetworkInterfaceAttribute",
                "ec2:DescribeNetworkInterfaces"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}


/*
resource "aws_iam_role_policy" "setupFilesAccesspolicy" {
  name = "${var.name}.setupFilesAccessPolicy"
  role = "${aws_iam_role.defaultEc2Role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:List*"],
      "Resource": ["arn:aws:s3:::${var.setupFilesBucket}"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:Get*"],
      "Resource": ["arn:aws:s3:::${var.setupFilesBucket}/*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eolFilesAcessPolicy" {
  name = "${var.name}.eolFilesAcessPolicy"
  role = "${aws_iam_role.defaultEc2Role.id}"

  #path = "/"
  # description = " Allow access to EOL Setup S3 bucket"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:List*"],
      "Resource": ["arn:aws:s3:::${var.eolFilesBucket}"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:Get*"],
      "Resource": ["arn:aws:s3:::${var.eolFilesBucket}/*"]
    }
  ]
}
EOF
}
*/
resource "aws_iam_role_policy" "AmazonEC2RoleforSSM" {
  name = "${var.name}.AmazonEC2RoleforSSM"
  role = "${aws_iam_role.defaultEc2Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ds:CreateComputer",
                "ds:DescribeDirectories"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::amazon-ssm-packages-*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "AWSMarketplaceFullAccess" {
  name = "${var.name}.AWSMarketplaceFullAccess"
  role = "${aws_iam_role.defaultEc2Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "aws-marketplace:*",
                "cloudformation:CreateStack",
                "cloudformation:DescribeStackResource",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStacks",
                "cloudformation:List*",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CreateSecurityGroup",
                "ec2:CreateTags",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DeleteSecurityGroup",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:DescribeKeyPairs",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeTags",
                "ec2:DescribeVpcs",
                "ec2:RunInstances",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}
