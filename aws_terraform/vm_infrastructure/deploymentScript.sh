#! /bin/bash
sudo yum -y update && sudo yum -y install httpd
sudo systemctl start httpd && sudo systemctl enable httpd 
sudo yum -y install git
git clone https://github.com/CREPIC21/MyWebsite.git
sudo rm /var/www/html/index.html
sudo mv /home/ec2-user/MyWebsite/index.html /var/www/html/
sudo mv /home/ec2-user/MyWebsite/style.css /var/www/html/
sudo mv /home/ec2-user/MyWebsite/script.js /var/www/html/
sudo mv /home/ec2-user/MyWebsite/images/ /var/www/html/