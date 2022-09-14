resource "aws_ecr_repository" "wijha-docker-repo" {
  name                 = "wijha-docker-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
