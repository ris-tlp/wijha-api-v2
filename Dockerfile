FROM python:3.9

WORKDIR /wijha-api-v2/
COPY . /wijha-api-v2/

RUN pip install pipenv
RUN pipenv requirements > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["gunicorn", "wijha_api_conf.wsgi"]
