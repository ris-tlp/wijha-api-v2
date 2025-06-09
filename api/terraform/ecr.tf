resource "aws_ecrpublic_repository" "wijha-docker-repo" {
  provider = aws.us_east_1

  repository_name = "wijha-docker-repo"

  catalog_data {
    about_text = "All docker images involved with wijha backend"
  }

  tags = {
    env = "dev"
  }
}
