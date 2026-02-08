#!/bin/bash
yum update -y
yum install -y httpd unzip wget

systemctl start httpd
systemctl enable httpd

cd /tmp

# Download website
wget https://freewebsitetemplates.com/download/treepreservation/ -O treepreservation.zip

# Unzip
unzip treepreservation.zip

# Remove Apache default page
rm -f /var/www/html/index.html

# Copy website CONTENTS (not folder)
cp -r treepreservation/* /var/www/html/

# Permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

systemctl restart httpd
