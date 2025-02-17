#!/bin/bash

# Parse arguments
for arg in "$@"; do
    eval "$arg"
done


# Status variables
Yellow_Color='\033[0;93m';
Green_Color='\033[0;92m';
No_Color='\033[0m';


# Define variables
domain="$domain"
ip_address="${ip:-localhost}"
server_port="$port"
nginx_conf_path="./$domain.conf"
nginx_symlink_path="/etc/nginx/sites-enabled/$domain"
web_root="/var/www/html"

if [ -z "$domain" ]; then
   echo -e "${Yellow_Color}Error: Domain is required. ${No_Color}"
   exit 1

fi
if [ -z "$server_port" ]; then
   echo -e "${Yellow_Color}Error: Server port is required. ${No_Color}"
   exit 1

fi

echo -e "${Green_Color} ${domain} point to ${ip_address}:${server_port}${No_Color}"


# Create the Nginx configuration file
cat <<EOF > "$nginx_conf_path"
upstream $domain {
    server $ip_address:$server_port;
}

server {
    listen 80;
    server_name $domain;

    proxy_set_header Host \$http_host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;

    client_max_body_size 1000M;

    location / {
        proxy_pass http://$domain;
    }

    error_page 502 /502.html;
    location = /502.html {
        root $web_root;
        internal;
    }
}
EOF

# Enable the configuration
#ln -sfn "$nginx_conf_path" "$nginx_symlink_path"

# Test Nginx configuration
nginx -t && systemctl reload nginx

echo -e "${Green_Color} Nginx configuration for $domain has been set up and reloaded. ${No_Color}"
