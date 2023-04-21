#!/bin/bash

GIT="https://github.com/CREPIC21/MyWebsite.git"
sudo yum -y update && sudo yum -y install httpd
sudo systemctl start httpd && sudo systemctl enable httpd 
sudo yum -y install git
sudo mkdir apps
git clone $GIT apps/MyWebsite
sudo rm /var/www/html/index.html
sudo mv apps/MyWebsite/index.html /var/www/html/
sudo mv apps/MyWebsite/style.css /var/www/html/
sudo mv apps/MyWebsite/script.js /var/www/html/
sudo mv apps/MyWebsite/images/ /var/www/html/