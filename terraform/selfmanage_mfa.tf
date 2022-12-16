provider "aws" {
}

resource "aws_iam_policy" "IamPolicy" {
  description = "An IAM policy that allows IAM users to self-manage an MFA device. This policy provides the permissions necessary to complete this action using the AWS API or AWS CLI only."
  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:DeleteVirtualMFADevice"
      ],
      "Resource": [
        "arn:aws:iam::*:mfa/${aws:username}",
        "arn:aws:iam::*:user/${aws:username}"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:DeactivateMFADevice"
      ],
      "Resource": [
        "arn:aws:iam::*:mfa/${aws:username}",
        "arn:aws:iam::*:user/${aws:username}"
      ],
      "Effect": "Allow",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    },
    {
      "Action": [
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ListUsers"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
)

}