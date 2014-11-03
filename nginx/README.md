#### Download nginx.sh

```bash
^_^[Mitesh@Shah:~]$ wget -c https://raw.githubusercontent.com/rtCamp/launchpad/master/nginx.sh
```

#### Execute nginx.sh

```bash
^_^[Mitesh@Shah:~]$ bash nginx.sh 1.6.2 Mr.Miteshah@gmail.com
```

1. [init-system-helpers package] (https://github.com/rtCamp/launchpad/blob/nginx-official/nginx/README.md#init-system-helpers-package)
2. [Nginx package] (https://github.com/rtCamp/launchpad/blob/nginx-official/nginx/README.md#nginx-package)

## init-system-helpers package
**Note:** Package dh-systemd is not available for Ubuntu 12.04

Follow below steps to build init-system-helpers package for Ubuntu 12.04

##### Modify Changelog

```bash
^_^[Mitesh@Shah:~]$ vim ~/PPA/nginx/nginx-1.6.2/debian/changelog
init-system-helpers (1.7~1ppa~precise) precise; urgency=low

  * No-change backport to precise

 -- Mitesh Shah <Mr.Miteshah@gmail.com>  Mon, 3 Nov 2014 13:05:32 +0530

```

##### Make A Debian Source For Upload To PPA:
```bash
^_^[Mitesh@Shah:~]$ cd ~/PPA/init-system-helpers/init-system-helpers-1.7
^_^[Mitesh@Shah:~]$ debuild -S -k'387AFF02'
```

##### Let Upload To LaunchPad:

```bash
^_^[Mitesh@Shah:~]$ dput ppa:rtcamp/nginx ~/PPA/init-system-helpers/init-system-helpers_1.7-1ppa~precise_source.changes
```

## Nginx package
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
