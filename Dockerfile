FROM python:3.8

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY "app.py" .

COPY "config.py" .

COPY "model_saved" .

ADD templates templates

ADD tests tests

ENV FLASK_APP=app.py

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts

RUN chmod +x /scripts/wait-for-it.sh

ENTRYPOINT ["/scripts/wait-for-it.sh", "psql_db:5432", "--"]

CMD ["python", "app.py", "runserver", "--host=0.0.0.0", "--threaded"]