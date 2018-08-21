#!/bin/bash
sudo yum install httpd -y
sudo echo "Hello BP World" >> /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on