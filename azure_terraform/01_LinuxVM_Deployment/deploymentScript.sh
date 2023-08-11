#!/bin/bash
GIT="https://github.com/CREPIC21/MyWebsite.git"
sudo apt update && apt full-upgrade -y
sudo apt update && apt install apache2 -y
sudo systemctl start apache2 && sudo systemctl enable apache2 
sudo apt install git -y
sudo mkdir apps
git clone $GIT apps/MyWebsite
sudo rm /var/www/html/index.html
sudo mv apps/MyWebsite/index.html /var/www/html/
sudo mv apps/MyWebsite/style.css /var/www/html/
sudo mv apps/MyWebsite/script.js /var/www/html/
sudo mv apps/MyWebsite/images/ /var/www/html/


