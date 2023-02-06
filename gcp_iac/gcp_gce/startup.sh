#! /bin/bash
sudo apt-get update
sudo apt update
sudo apt -y install apache2
sudo apt -y install git
sudo git clone https://github.com/CREPIC21/MyWebsite.git
sudo rm /var/www/html/index.html
sudo mv /home/crepic21/MyWebsite/index.html /var/www/html/
sudo mv /home/crepic21/MyWebsite/style.css /var/www/html/
sudo mv /home/crepic21/MyWebsite/script.js /var/www/html/
sudo mv /home/crepic21/MyWebsite/images/ /var/www/html/


