resource "aws_ecr_repository" "GameHighlightsECR" {
  name                 = "gamehighlights-ecr"
  image_tag_mutability = "MUTABLE"
}