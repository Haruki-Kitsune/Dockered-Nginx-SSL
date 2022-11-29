FROM nginx:1.23-alpine

COPY ./nginx/* /etc/nginx/
COPY ./run.sh /run.sh

# Here you give the name and port
# of the service behind nginx.
ENV APP_HOST=app_name
ENV APP_PORT=app_port

USER root

# OpenSSL is not included so we
# need to download it first.
RUN apk add --no-cache openssl
# Makes the run.sh file executable.
RUN chmod +x /run.sh

VOLUME /vol/www

# Executes a command.
CMD ["/run.sh"]
