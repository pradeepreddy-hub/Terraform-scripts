provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-s3-pradeep"

  tags = {
    Name        = "example-s3-bucket"
    Environment = "dev"
  }
}

# (Optional but recommended)
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "example" {
  name         = "my-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "example-dynamodb"
    Environment = "dev"
  }
}

