FROM python:3.9-slim

WORKDIR /app
ADD requirements.txt ./
ADD database.db ./
ADD modales.py ./
RUN pip install -r requirements.txt


CMD python /app/routes.py

EXPOSE 5000

ADD routes.py ./