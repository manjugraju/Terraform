#! /bin/bash
sudo yum install httpd -y
sudo systemctl enable httpd 
echo "This is a web page from userdata" > /var/www/html/index.html
sudo systemctl start httpd 