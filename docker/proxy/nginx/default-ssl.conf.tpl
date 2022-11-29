upstream prodapp {
    # This is the container that we want to access.
    server prod_app:port_number;
}

server {
    listen 80;
    listen [::]:80;

    # Domain name is given with an environment variable.
    server_name ${DOMAIN} www.${DOMAIN};

    # This allows for auto renewal of ssl certificate.
    location /.well-known/acme-challenge/ {
        root /vol/www/;
    }

    # This will redirect all request made to port 80 to port 443.
    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    listen [::]:443 ssl ipv6only=on;
    
    client_max_body_size 10M;

    # Domain name is given with an environment variable.
    server_name ${DOMAIN} www.${DOMAIN};

    # Loads in the variables for the ssl certificate.
    ssl_certificate     /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;

    # includes settings from certbot for nginx proxy.
    include /etc/nginx/options-ssl-nginx.conf;

    # Loads the dhparams for SSL from a file.
    ssl_dhparam /vol/proxy/ssl-dhparams.pem;

    # Misc proxy settings.
    add_header Strict-Transport-Security "max-age=31536000;
    includeSubDomains" always;
    
    # Handles all the request to the static files.
    rewrite "/static/\d+/(.*)" /static/$1 last;
    location /static/ {
        alias /path/to/static/;
    }

    location / {
        # Let the request pass to the upstream.
        proxy_pass http://prodapp;

        # Includes the uwsgi parameters.
        include /etc/nginx/uwsgi_params;
    }
}
