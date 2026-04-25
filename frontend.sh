# !/bin/bash

# Install Nginx and Node.js for the frontend application 
dnf install -y nginx
systemctl start nginx

#  Install Node.js for the frontend application and version 20.x is used as an example, you can change it to the version you need   
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs

# Download the frontend application code, build it, and copy the built files to the Nginx web server directory

curl -L -o /tmp/frontend.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip
mkdir -p /tmp/frontend && cd /tmp/frontend
unzip /tmp/frontend.zip
npm install
npm run build
rm -rf /usr/share/nginx/html/*
cp -r out/* /usr/share/nginx/html/

# copy nginx.conf to the nginx configuration directory

# cp nginx.conf /etc/nginx/default.d/roboshop.conf

# replace the default nginx.conf with the one provided in the repository to configure the reverse proxy for the frontend application
cp nginx.conf /etc/nginx/nginx.conf

nginx -t
systemctl restart nginx
systemctl enable nginx
