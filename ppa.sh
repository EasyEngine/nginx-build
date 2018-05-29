#!/bin/bash



# Define NGINX version
PACKAGE_NAME=$1
NGINX_VERSION=$2
EMAIL_ADDRESS=$3

# Capture errors
function ppa_error()
{
	echo "[ `date` ] $(tput setaf 1)$@$(tput sgr0)"
	exit $2
}

# Echo function
function ppa_lib_echo()
{
	echo $(tput setaf 4)$@$(tput sgr0)
}

# Update/Install Packages
ppa_lib_echo "Execute: apt-get update, please wait"
sudo apt-get update || ppa_error "Unable to update packages, exit status = " $?
ppa_lib_echo "Installing required packages, please wait"
sudo apt-get -y install git dh-make devscripts debhelper dput gnupg-agent dh-systemd vim || ppa_error "Unable to install packages, exit status = " $?

# Lets Clone Launchpad repository
ppa_lib_echo "Copy Launchpad Debian files, please wait"
rm -rf /tmp/launchpad && rsync -az nginx /tmp/launchpad/ \
|| ppa_error "Unable to clone launchpad repo, exit status = " $?

# Configure NGINX PPA
mkdir -p ~/PPA/$PACKAGE_NAME && cd ~/PPA/$PACKAGE_NAME \
|| ppa_error "Unable to create ~/PPA/$PACKAGE_NAME, exit status = " $?

# Download NGINX
ppa_lib_echo "Download nginx, please wait"
wget -c http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
|| ppa_error "Unable to download nginx-${NGINX_VERSION}.tar.gz, exit status = " $?
tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
|| ppa_error "Unable to extract nginx, exit status = " $?
cd nginx-${NGINX_VERSION} \
|| ppa_error "Unable to change directory, exit status = " $?

# Lets start building
ppa_lib_echo "Execute: dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig, please wait"
dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig \
|| ppa_error "Unable to run dh_make command, exit status = " $?
rm debian/*.ex debian/*.EX \
|| ppa_error "Unable to remove unwanted files, exit status = " $?

# Let's copy files
cp -av /tmp/launchpad/nginx/debian/* ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/ \
|| ppa_error "Unable to copy launchpad debian files, exit status = " $?

# NGINX modules
ppa_lib_echo "Downloading NGINX modules, please wait"
mkdir ~/PPA/nginx/modules && cd ~/PPA/nginx/modules \
|| ppa_error "Unable to create ~/PPA/nginx/modules, exit status = " $?

ppa_lib_echo "1/18 headers-more-nginx-module"
git clone https://github.com/agentzh/headers-more-nginx-module.git \
|| ppa_error "Unable to clone headers-more-nginx-module repo, exit status = " $?

ppa_lib_echo "2/18 naxsi "
git clone https://github.com/nbs-system/naxsi \
|| ppa_error "Unable to clone naxsi repo, exit status = " $?
cp -av ~/PPA/nginx/modules/naxsi/naxsi_config/naxsi_core.rules ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/conf/ \
|| ppa_error "Unable to copy naxsi files, exit status = " $?

ppa_lib_echo "3/18 nginx-auth-pam"
git clone https://github.com/sto/ngx_http_auth_pam_module nginx-auth-pam  \
|| ppa_error "Unable to clone ngx_http_auth_pam_module repo, exit status = " $?

ppa_lib_echo "4/18 nginx-cache-purge"
git clone https://github.com/FRiCKLE/ngx_cache_purge.git nginx-cache-purge \
|| ppa_error "Unable to clone nginx-cache-purge repo, exit status = " $?

ppa_lib_echo "5/18 nginx-dav-ext-module"
git clone https://github.com/arut/nginx-dav-ext-module.git \
|| ppa_error "Unable to clone nginx-dav-ext-module repo, exit status = " $?

ppa_lib_echo "6/18 nginx-development-kit"
git clone https://github.com/simpl/ngx_devel_kit.git nginx-development-kit \
|| ppa_error "Unable to clone nginx-development-kit repo, exit status = " $?

ppa_lib_echo "7/18  nginx-echo"
git clone https://github.com/agentzh/echo-nginx-module.git nginx-echo \
|| ppa_error "Unable to clone nginx-echo repo, exit status = " $?

ppa_lib_echo "8/18 nginx-lua"
git clone https://github.com/chaoslawful/lua-nginx-module.git nginx-lua \
|| ppa_error "Unable to clone nginx-lua repo, exit status = " $?

ppa_lib_echo "9/18 nginx-upload-progress-module"
git clone https://github.com/masterzen/nginx-upload-progress-module.git nginx-upload-progress \
|| ppa_error "Unable to clone nginx-upload-progress repo, exit status = " $?

ppa_lib_echo "10/18 nginx-upstream-fair"
git clone https://github.com/itoffshore/nginx-upstream-fair.git \
|| ppa_error "Unable to clone nginx-upstream-fair repo, exit status = " $?

ppa_lib_echo "11/18 ngx-fancyindex"
git clone https://github.com/aperezdc/ngx-fancyindex.git ngx-fancyindex \
|| ppa_error "Unable to clone ngx-fancyindex repo, exit status = " $?

ppa_lib_echo "12/18 ngx_http_substitutions_filter_module"
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module.git \
|| ppa_error "Unable to clone ngx_http_substitutions_filter_module repo, exit status = " $?

ppa_lib_echo "13/18 memc-nginx-module"
git clone https://github.com/openresty/memc-nginx-module.git \
|| ppa_error "Unable to clone memc-nginx-module repo, exit status = " $?

ppa_lib_echo "14/18 srcache-nginx-module"
git clone https://github.com/openresty/srcache-nginx-module.git \
|| ppa_error "Unable to clone srcache-nginx-module repo, exit status = " $?

ppa_lib_echo "15/18 HttpRedisModule"
git clone https://github.com/EasyEngine/ngx_http_redis.git HttpRedisModule \
|| ppa_error "Unable to clone nginx_http_redis_module repo, exit status = " $?

ppa_lib_echo "16/18 redis2-nginx-module"
git clone https://github.com/openresty/redis2-nginx-module.git \
|| ppa_error "Unable to clone redis2-nginx-module repo, exit status = " $?

ppa_lib_echo "17/18 ngx_devel_kit-module"
git clone https://github.com/simpl/ngx_devel_kit.git \
|| ppa_error "Unable to clone ngx_devel_kit-module repo, exit status = " $?

ppa_lib_echo "18/18 set-misc-nginx-module"
git clone https://github.com/openresty/set-misc-nginx-module.git \
|| ppa_error "Unable to clone set-misc-nginx-module repo, exit status = " $?

cp -av ~/PPA/nginx/modules ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/ \
|| ppa_error "Unable to copy modules files, exit status = " $?

# Edit changelog
vim ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/changelog
