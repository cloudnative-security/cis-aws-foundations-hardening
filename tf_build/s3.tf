resource "aws_s3_bucket" "aws_demo_bucket" {
  bucket = "aws_demo_s3_bucket-${random_id.bucket_id.hex}"
  acl    = "public-read"
  force_destroy = true

  tags {
    Name        = "aws_demo_bucket"
    Environment = "prod"
  }
}

output "s3_bucket_name" {
  value = "aws_demo_s3_bucket-${random_id.bucket_id.hex}"
}

# add s3 bucket elements - pub

resource "aws_s3_bucket_object" "public-read" {
  bucket = "aws_demo_s3_bucket-${random_id.bucket_id.hex}"
  acl    = "public-read"
  key    = "public-pic-read.jpg"
  source = "./data/public-pic.jpg"
  etag   = "${md5(file("./data/public-pic.jpg"))}"

  depends_on = ["aws_s3_bucket.aws_demo_bucket"]
}

# add s3 bucket elements - pub Authenticated Users only

resource "aws_s3_bucket_object" "authenticated-read" {
  bucket = "aws_demo_s3_bucket-${random_id.bucket_id.hex}"
  acl    = "authenticated-read"
  key    = "public-pic-authenticated.jpg"
  source = "./data/public-pic.jpg"
  etag   = "${md5(file("./data/public-pic.jpg"))}"

  depends_on = ["aws_s3_bucket.aws_demo_bucket"]
}
# add s3 bucket elements - pri

resource "aws_s3_bucket_object" "private" {
  bucket = "aws_demo_s3_bucket-${random_id.bucket_id.hex}"
  acl = "private"
  key    = "private-pic.jpg"
  source = "./data/private-pic.jpg"
  etag   = "${md5(file("./data/private-pic.jpg"))}"

  depends_on = ["aws_s3_bucket.aws_demo_bucket"]
}
