docker run -ti -p 8000:8000 -v "$(pwd):/var/task" -v ~/.aws/:/root/.aws --rm zappa-docker-image:latest
