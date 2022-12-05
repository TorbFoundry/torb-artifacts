FROM python:3.9

WORKDIR /code

COPY ./ .

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

EXPOSE 5000
CMD ["gunicorn", "--conf", "gunicorn_conf.py", "--bind", "0.0.0.0:5000", "app:app"]
