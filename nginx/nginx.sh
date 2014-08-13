#!/bin/bash



# Define NGINX version
NGINX_VERSION=$1
EMAIL_ADDRESS=Mr.Miteshah@gmail.com

# Update/Install Packages
sudo apt-get update
sudo apt-get -y install git dh-make devscripts debhelper dput gnupg-agent

# Configure PPA
mkdir -p ~/PPA/nginx
cd ~/PPA/nginx

# Download NGINX
wget -c http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -zxvf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}

# Lets start building
dh_make --single --native --copyright gpl --email $EMAIL_ADDRESS
rm debian/*.ex debian/*.EX

# Lets copy files
cp -av conf debian/
mkdir debian/conf/sites-available


# NGINX modules
mkdir ~/PPA/nginx/modules
cd ~/PPA/nginx/modules

git clone https://github.com/agentzh/headers-more-nginx-module.git

git clone https://github.com/nbs-system/naxsi
cp -av ~/PPA/nginx/modules/naxsi/naxsi_config/naxsi_core.rules ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/conf/

wget http://web.iti.upv.es/~sto/nginx/ngx_http_auth_pam_module-1.3.tar.gz
tar -zxvf ngx_http_auth_pam_module-1.3.tar.gz
mv ngx_http_auth_pam_module-1.3 nginx-auth-pam
rm ngx_http_auth_pam_module-1.3.tar.gz

git clone https://github.com/FRiCKLE/ngx_cache_purge.git nginx-cache-purge

git clone https://github.com/arut/nginx-dav-ext-module.git
	
git clone https://github.com/simpl/ngx_devel_kit.git nginx-development-kit
	
git clone https://github.com/agentzh/echo-nginx-module.git nginx-echo 
	
git clone https://github.com/slact/nginx_http_push_module.git nginx-http-push
	
git clone https://github.com/chaoslawful/lua-nginx-module.git nginx-lua
	
git clone https://github.com/masterzen/nginx-upload-progress-module.git nginx-upload-progress
	
git clone https://github.com/gnosek/nginx-upstream-fair.git

git clone git://github.com/yaoweibin/ngx_http_substitutions_filter_module.git

cp -av ~/PPA/nginx/modules ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/

