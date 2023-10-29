<<<<<<< HEAD
#!/bin/bash 
#Author: michael_kedey 
#Date: 19/10/2023 
#Last_modified: 25/10/2023 
#Purpose: install nginx and set up reverse proxy and change default ssh port 
 
sudo apt-get update 
sudo apt-get upgrade -y 
 
#install nginx and start the service 
sudo apt-get install -y nginx 
sudo systemctl enable nginx 
 
echo -e '<h1>Congrats! you have installed nginx</h1> 
<h3>You have succesfully configured a proxey server as well</h3> 
<h3>Your configurations include the following</h3> 
<ol> 
  <li>VPC and 3 subnets, 2 route tables and 2 route table attachements</li> 
  <li>Load balancer and listener</li> 
  <li>Target group</li> 
  <li>2 Security groups</li> 
  <li>Internet Gateway</li> 
  <li>NAT Gateway</li> 
  <li>EC2</li> 
  <li>EIP for the NAT Gateway</li> 
  <li>Shell script to run at boot time for the Ec2</li> 
  <li>5 SSM Parameter resources</li> 
</ol> 
<ul> 
  <li><a href="https://www.github.com/michaelkedey">Github</a></li> 
  <li><a href="https://www.linkedin.com/in/michaelkedey">LinkedIn</a></li> 
</ul> 
<h6>Great Job. cc michael_kedey</h6>' > /var/www/html/index.html 
 
 
# Remove the default site available 
sudo rm /etc/nginx/sites-available/default 
sudo rm /etc/nginx/sites-enabled/default 
 
# Set up a reverse proxy in NGINX to forward requests to the local server 
#local_server="http://localhost:80" 
sudo tee /etc/nginx/sites-available/reverse_proxy.conf <<EOF 
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
 
#create a link of the available site in the sites-enabled directory 
ln -s /etc/nginx/sites-available/reverse_proxy.conf /etc/nginx/sites-enabled/ 
 
sudo systemctl restart nginx 
=======
#!/bin/bash

# this script will install nginx and some other config

#update system
sudo apt-get update
sudo apt-get upgrade 

#install nginx
sudo apt-get install nginx -y

echo -e '<h1>Congrats! You have installed Nginx</h1>
<h3>You have successfully configured a proxy server as well</h3>
<h4>Your configurations include a VPC, 3 subnets, route tables, security groups, target group, EC2, and a shell script</h4>

<h3>Meet the contributors</h3>
<ol>
  <li><a href="https://github.com/DelaDoreen">Doreen Dela Agbedoe</a></li>
  <li><a href="https://github.com/konaydu">Konadu Owusu-Ansah</a></li>
  <li><a href="https://github.com/Gina1010">Gina Tetteh</a></li>
  <li><a href="https://github.com/Kattafuah">Kwasi Attafua</a></li>
  <li><a href="https://github.com/seyramgabriel">Seyram Gabriel</a></li>
  <li><a href="https://github.com/HABIETU-FUSEINI">Habietu</a></li>
  <li>Kojo</li>
  <li><a href = "https://github.com/vimray009">Raymond Lorlornyo Havim<a/></li>
  <li><a href="https://github.com/michaelkedey">Michael Kedey</a></li>
</ol>
<h5>Great job!</h5>' > /var/www/html/index.html


#start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

#create proxy server to listen on port 80
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






>>>>>>> 61555cc5d1cde23f9219205ed756b57d856111ad
