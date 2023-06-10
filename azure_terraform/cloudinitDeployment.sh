#cloud-config
package_upgrade: true
packages:
  - apache2
  - git
runcmd:
  - sudo systemctl start apache2
  - sudo systemctl enable apache2 
  - mkdir apps
  - git clone https://github.com/CREPIC21/MyWebsite.git apps/MyWebsite
  - rm /var/www/html/index.html
  - mv apps/MyWebsite/index.html /var/www/html/
  - mv apps/MyWebsite/style.css /var/www/html/
  - mv apps/MyWebsite/script.js /var/www/html/
  - mv apps/MyWebsite/images/ /var/www/html/
