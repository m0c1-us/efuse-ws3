terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


#S3 Bucket on Which we will add policy
resource "aws_s3_bucket" "efuse-bucket"{
  bucket = "ck-efuse-bucket"
}

#Resource to add bucket policy to a bucket 
resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.efuse-bucket.id
  policy = data.aws_iam_policy_document.public_read_access.json
}

#DataSource to generate a policy document
data "aws_iam_policy_document" "public_read_access" {
  statement {
    principals {
	  type = "*"
	  identifiers = ["*"]
	}

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl"'
    ]

    resources = [
      aws_s3_bucket.efuse-bucket.arn,
      "${aws_s3_bucket.efuse-bucket.arn}/*",
    ]
  }
}
