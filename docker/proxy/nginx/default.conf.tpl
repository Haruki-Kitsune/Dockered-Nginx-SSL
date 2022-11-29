server {
    listen 80;
    
    # The domain names the proxy will listen to.
    server_name ${DOMAIN} www.${DOMAIN};
    
    # The URL which letsencrypt uses to check
    # if everything is valid for a SSL certificate.
    location /.well-known/acme-challenge/ {
        root /vol/www/;
    }
    
    # Redirect to HTTPS SSL
    location / {
        return 301 https://$host$request_uri;
    }
}
