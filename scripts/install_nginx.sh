#!/bin/bash

# Update package list
sudo apt-get update -y

# Install NGINX
sudo apt-get install nginx -y

# Enable and start NGINX service
sudo systemctl enable nginx
sudo systemctl start nginx

# Optional: Add a welcome message
echo "<h1>Welcome to Azure Web VM - Provisioned by Terraform</h1>" | sudo tee /var/www/html/index.html
