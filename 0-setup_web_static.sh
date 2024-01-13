#!/usr/bin/env bash
# Double the number of webservers.
sudo apt-get update
sudo apt-get -y install nginx
#sudo chown $USER:$USER /var/www/html/index.html
sudo touch index.html /var/www/html/
echo 'Holberton School' > /var/www/html/index.html
sudo mkdir /var/www/error
#sudo chown  $USER:$USER /var/www/error/
echo "Ceci n'est pas une page" > /var/www/error/404.html
#sudo chown  $USER:$USER /etc/nginx/sites-available/
sed -i '/server_name _/a location /redirect_me { rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlw\u4? permanent; }' /etc/nginx/sites-available/default
sed -i '/server_name _/a error_page 404 /404.html; location = /404.html {root /var/www/error/; internal; }' /etc/nginx/sites-available/default
# in the server 1 also 2 this down
sudo sed -i "/server_name _/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-available/default
# sets up your web servers for the deployment of web_static. It must in airbnb
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/
#sudo chown $USER:$USER /data/web_static/releases/test/
echo "Holberton School" > /data/web_static/releases/test/index.html
#el comando de abajo permite copiar el contenido del directorio inicial al otro current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sed -i "/^\tlocation \/ {$/ i\\\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n}" /etc/nginx/sites-available/default
sudo service nginx restart
