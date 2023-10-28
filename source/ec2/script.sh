


#!/bin/bash


# this script will install nginx and some other configurations.
# Name of Author :
# Date Created: 
# Last Modified by:
# Description :This script will Install nginx and some other config.


#update system
sudo apt-get update
sudo apt-get upgrade 

#install nginx
sudo apt-get install nginx -y

#start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

#create proxy server to listen on  the port 80
sudo tee /etc/nginx/sites-available/practice.conf <<-EOF
server {
  listen 80;

  location / {
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass http_upgrade;
    ProxyPass http://localhost:80/;
  }
}

ln -s /etc/nginx/sites-available/practice.conf /etc/nginx/sites-enabled/






# echo -e '<h1>Congrats! you have installed nginx</h1>
# <h3>You have succesfully configured a proxey server as well</h3>
# <h3>Your configurations include the following</h3>
# <ol>
#   <li>VPC and 3 subnets, 2 route tables and 2 route table attachements</li>
#   <li>Load balancer and listener</li>
#   <li>Target group</li>
#   <li>2 Security groups</li>
#   <li>Internet Gateway</li>
#   <li>NAT Gateway</li>
#   <li>EC2</li>
#   <li>EIP for the NAT Gateway</li>
#   <li>Shell script to run at boot time for the Ec2</li>
#   <li>5 SSM Parameter resources</li>
# </ol>
# <ul>
#   <li><a href="https://www.github.com/michaelkedey">Github</a></li>
#   <li><a href="https://www.linkedin.com/in/michaelkedey">LinkedIn</a></li>
# </ul>
# <h6>Great Job. cc michael_kedey</h6>' > /var/www/html/index.html


