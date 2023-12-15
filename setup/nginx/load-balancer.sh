#!/bin/bash

sudo apt update

echo "Installing nginx..."
sudo apt install nginx

# Konten konfigurasi Nginx
echo "upstream app {
    server 172.208.23.151:8000;
    server 172.208.82.223:8000;
}

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://app;
    }
}
" | sudo tee /etc/nginx/sites-available/my_proxy

# Membuat tautan simbolik ke sites-enabled
sudo ln -s /etc/nginx/sites-available/my_proxy "/etc/nginx/sites-enabled/"

sudo rm /etc/nginx/sites-enabled/default

# Melakukan uji sintaks konfigurasi Nginx
sudo nginx -t

# Merestart Nginx untuk menerapkan konfigurasi baru
sudo systemctl restart nginx

sudo ufw status
sudo ufw enable
sudo ufw allow 80
