#### Download nginx.sh

```bash
^_^[Mitesh@Shah:~]$ wget -c https://raw.githubusercontent.com/rtCamp/launchpad/master/ppa.sh
```

#### Execute ppa.sh

```bash
^_^[Mitesh@Shah:~]$ bash ppa.sh nginx 1.6.2 Mr.Miteshah@gmail.com
```

## Nginx package
**Note:** Package dh-systemd is not available for Ubuntu 12.04
If you want to build nginx for Ubuntu 12.04 then you have to first build [init-system-helpers packaage] (https://github.com/rtCamp/launchpad/blob/nginx-official/init-system-helpers/README.md)

##### Modify Changelog

```bash
^_^[Mitesh@Shah:~]$ vim ~/PPA/nginx/nginx-1.6.2/debian/changelog
nginx (1.6.2-1ppa~trusty) trusty; urgency=low

  * Remove nginx-naxsi package
  * Remove nginx-pagespeed package
  * Add ngx_pagespeed in nginx-extras package

 -- Mitesh Shah <Mr.Miteshah@gmail.com>   Wed, 29 Oct 2014 18:57:39 +0530

```

##### Make A Debian Source For Upload To PPA:

```bash
^_^[Mitesh@Shah:~]$ cd ~/PPA/nginx/nginx-1.6.2
# For new nginx version 1.6.2
^_^[Mitesh@Shah:~]$ debuild -S -sa -k'387AFF02'
# For minor changes on existing nginx 1.6.2
# Download nginx_1.6.2.orig.tar.xz from launchpad
^_^[Mitesh@Shah:~]$ debuild -S -k'387AFF02'
```

##### Let Upload To LaunchPad:

```bash
^_^[Mitesh@Shah:~]$ dput ppa:rtcamp/nginx ~/PPA/nginx/nginx_1.6.2-1ppa~trusty_source.changes
```
