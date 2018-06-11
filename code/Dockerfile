FROM python:2-alpine

WORKDIR /app

ADD *py /app/
ADD requirements.txt /app/
ADD run-flask.sh /app/
RUN pip install -r requirements.txt

CMD ["sh", "run-flask.sh"]
