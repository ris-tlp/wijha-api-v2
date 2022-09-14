resource "aws_apprunner_service" "wijha-api-v2" {
  service_name = "wijha-api-v2"

  source_configuration {

    image_repository {
      image_configuration {
        port = "8081"
      }
      image_identifier      = "public.ecr.aws/h9z2v7x9/wijha-docker-repo:latest"
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = false
  }

  instance_configuration {
    cpu    = 1024
    memory = 2048
  }

  tags = {
    Name = "wijha-api-v2"
  }
}
