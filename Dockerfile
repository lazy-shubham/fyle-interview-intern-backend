FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt /app

RUN apt-get update && apt-get install -y build-essential

RUN pip install -r requirements.txt

COPY . /app

ENV FLASK_APP=core/server.py GUNICORN_PORT=5000

RUN flask db upgrade -d core/migrations/

CMD ["gunicorn", "-c", "gunicorn_config.py", "core.server:app"]
