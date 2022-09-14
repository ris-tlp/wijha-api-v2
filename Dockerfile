FROM python:3.9-slim

WORKDIR /wijha-api-v2/
COPY . /wijha-api-v2/

# Dependencies
RUN pip install --upgrade pip
RUN pip install pipenv
RUN pipenv requirements > requirements.txt
RUN pip install --user -r requirements.txt

EXPOSE 8081

CMD [ "python", "-m", "gunicorn", "-b", "0.0.0.0:8081", "wijha_api_conf.wsgi" ]
