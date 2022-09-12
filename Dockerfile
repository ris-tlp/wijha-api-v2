FROM mlupin/docker-lambda:python3.9-build

# Make this the default working directory
WORKDIR /var/task

# Expose tcp network port 8000 for debugging
EXPOSE 8000

# Install dependencies
RUN pip install pipenv
RUN python -m pipenv requirements > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["bash"]
