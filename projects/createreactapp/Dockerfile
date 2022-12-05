FROM bitnami/apache:latest
RUN echo 'Mutex posixsem' >>/opt/bitnami/apache2/conf/httpd.conf
COPY ./build /app