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
sudo apt-get -y install git dh-make devscripts debhelper dput gnupg-agent dh-systemd m4 bc dpkg-dev || ppa_error "Unable to install packages, exit status = " $?

# Lets Clone Launchpad repository
ppa_lib_echo "Copy Launchpad Debian files, please wait"
rm -rf /tmp/launchpad && git clone -b mainline https://github.com/rtCamp/nginx-build.git /tmp/launchpad \
|| ppa_error "Unable to clone launchpad repo, exit status = " $?

if [ "$PACKAGE_NAME" = "init-system-helpers" ]; then
	# Configure init-system-helpers for Ubuntu 12.04
	mkdir -p ~/PPA/$PACKAGE_NAME && cd ~/PPA/$PACKAGE_NAME \
	|| ppa_error "Unable to create ~/PPA/$PACKAGE_NAME, exit status = " $?

	# Clone init-system-helpers
	ppa_lib_echo "Clone init-system-helpers, please wait"
	git clone git://anonscm.debian.org/collab-maint/init-system-helpers.git init-system-helpers-1.7
	cd init-system-helpers-1.7 && git checkout debian/1.7 \
	|| ppa_error "Unable to checkout debian/1.7, exit status = " $?

	# Lets start building
	#ppa_lib_echo "Execute: dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig, please wait"
	#dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig \
	#|| ppa_error "Unable to run dh_make command, exit status = " $?

	# Let's copy files
	cp -av /tmp/launchpad/init-system-helpers/debian/* ~/PPA/init-system-helpers/init-system-helpers-1.7/debian/ \
	|| ppa_error "Unable to copy launchpad debian files, exit status = " $?

	# Edit changelog
	vim ~/PPA/init-system-helpers/init-system-helpers-1.7/debian/changelog

if [ "$PACKAGE_NAME" = "openssl" ]; then
	# Configure init-system-helpers for Ubuntu 12.04
	mkdir -p ~/PPA/$PACKAGE_NAME && cd ~/PPA/$PACKAGE_NAME \
	|| ppa_error "Unable to create ~/PPA/$PACKAGE_NAME, exit status = " $?
	https://www.openssl.org/source/openssl-1.0.2e.tar.gz
	# Clone init-system-helpers
	ppa_lib_echo "Downloading OpenSSL, please wait"
	wget -c https://www.openssl.org/source/openssl-${NGINX_VERSION}.tar.gz \
	|| ppa_error "Unable to download openssl-${NGINX_VERSION}.tar.gz, exit status = " $?
	tar -zxvf openssl-${NGINX_VERSION}.tar.gz \
	|| ppa_error "Unable to extract nginx, exit status = " $?
	cd openssl-${NGINX_VERSION} \
	|| ppa_error "Unable to change directory, exit status = " $?

	# Lets start building
	#ppa_lib_echo "Execute: dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig, please wait"
	#dh_make --single --copyright gpl --email $EMAIL_ADDRESS --createorig \
	#|| ppa_error "Unable to run dh_make command, exit status = " $?

	# Let's copy files
	cp -av /tmp/launchpad/openssl/debian ~/PPA/init-system-helpers/openssl-${NGINX_VERSION}/ \
	|| ppa_error "Unable to copy openssl debian files, exit status = " $?

	# Edit changelog
	vim ~/PPA/init-system-helpers/openssl-${NGINX_VERSION}/debian/changelog

elif [ "$PACKAGE_NAME" = "nginx" ]; then

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

	ppa_lib_echo "1/7 naxsi "
	git clone https://github.com/nbs-system/naxsi \
	|| ppa_error "Unable to clone naxsi repo, exit status = " $?
	cp -av ~/PPA/nginx/modules/naxsi/naxsi_config/naxsi_core.rules ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/conf/ \
	|| ppa_error "Unable to copy naxsi files, exit status = " $?

	ppa_lib_echo "2/7 memc-nginx-module"
	git clone https://github.com/openresty/memc-nginx-module.git memc-nginx-module \
	|| ppa_error "Unable to clone memc-nginx-module repo, exit status = " $?

	ppa_lib_echo "3/7 srcache-nginx-module"
	git clone https://github.com/openresty/srcache-nginx-module.git srcache-nginx-module \
	|| ppa_error "Unable to clone srcache-nginx-module repo, exit status = " $?

	ppa_lib_echo "4/7 redis2-nginx-module"
	git clone https://github.com/openresty/redis2-nginx-module.git redis2-nginx-module \
	|| ppa_error "Unable to clone redis2-nginx-module repo, exit status = " $?

	ppa_lib_echo "5/7 HttpRedisModule"
	wget http://people.freebsd.org/~osa/ngx_http_redis-0.3.7.tar.gz \
	|| ppa_error "Unable to download ngx_http_redis-0.3.7.tar.gz, exit status = " $?
	tar -zxvf ngx_http_redis-0.3.7.tar.gz \
	|| ppa_error "Unable to extract ngx_http_redis-0.3.7.tar.gz, exit status = " $?
	mv ngx_http_redis-0.3.7 HttpRedisModule \
	|| ppa_error "Unable to ngx_http_redis-0.3.7, exit status = " $?
	rm ngx_http_redis-0.3.7.tar.gz \
	|| ppa_error "ngx_http_redis-0.3.7.tar.gz, exit status = " $?

	ppa_lib_echo "6/7 set-misc-nginx-module"
	git clone https://github.com/openresty/set-misc-nginx-module.git set-misc-nginx-module \
	|| ppa_error "Unable to clone set-misc-nginx-module repo, exit status = " $?

	ppa_lib_echo "7/7 ngx_pagespeed"
	NPS_VERSION=1.9.32.6
	wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.tar.gz
	tar -zxvf release-${NPS_VERSION}-beta.tar.gz
	mv ngx_pagespeed-release-${NPS_VERSION}-beta  ngx_pagespeed
	rm release-${NPS_VERSION}-beta.tar.gz

	cd ngx_pagespeed
	wget -O psol.tar.gz https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz

	cp -av ~/PPA/nginx/modules/* ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/modules/ \
	|| ppa_error "Unable to copy launchpad modules files, exit status = " $?

	# Edit changelog
	vim ~/PPA/nginx/nginx-${NGINX_VERSION}/debian/changelog
fi
