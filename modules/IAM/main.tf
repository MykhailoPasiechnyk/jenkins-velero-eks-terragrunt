resource "aws_iam_policy" "velero_rolicy" {
  name        = "velero-${var.env}-policy"
  description = "EC2 Policy for Velero EKS Cluster"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::${var.velero_bucket}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.velero_bucket}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "${var.velero_user}-attachment"
  users      = ["${var.velero_user}"]
  policy_arn = aws_iam_policy.velero_rolicy.arn
}
