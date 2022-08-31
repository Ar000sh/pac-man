FROM python:3.9-slim

WORKDIR /app
ADD requirements.txt ./
# ADD db/ db/
# ADD modales.py ./
RUN pip install -r requirements.txt


# CMD python /app/routes.py
CMD python /app/modales.py
EXPOSE 5000

ADD modales.py ./
# ADD routes.py ./