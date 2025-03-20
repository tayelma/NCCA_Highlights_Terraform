resource "aws_s3_bucket" "highlights" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "GamesHighlights"
  }
}