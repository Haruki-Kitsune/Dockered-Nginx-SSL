FROM certbot/certbot:1.29.0

COPY certify-init.sh /opt/
RUN chmod +x /opt/certify-init.sh

ENTRYPOINT []
CMD ["Certbot", "renew"]
