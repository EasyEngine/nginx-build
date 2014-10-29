#### Download nginx.sh

```bash
^_^[Mitesh@Shah:~]$ wget -c https://raw.githubusercontent.com/MiteshShah/launchpad/master/nginx/nginx.sh
```

#### Execute nginx.sh

```bash
^_^[Mitesh@Shah:~]$ bash nginx.sh 1.6.1 Mr.Miteshah@gmail.com
```

#### Modify Changelog

```bash
^_^[Mitesh@Shah:~]$ vim ~/PPA/nginx/nginx-1.6.1/debian/changelog
nginx (1.6.1-1ppa~trusty) trusty; urgency=low

  * Remove nginx-naxsi package
  * Remove nginx-pagespeed package
  * Add ngx_pagespeed in nginx-extras package

 -- Mitesh Shah <Mr.Miteshah@gmail.com>   Wed, 29 Oct 2014 18:57:39 +0530

```

#### Make A Debian Source For Upload To PPA:

```bash
^_^[Mitesh@Shah:~]$ cd ~/PPA/nginx/nginx-1.6.1
# For new nginx version 1.6.2
^_^[Mitesh@Shah:~]$ debuild -S -sa -k'387AFF02'
# For minor changes on existing nginx 1.6.2
# Download nginx_1.6.2.orig.tar.xz from launchpad
^_^[Mitesh@Shah:~]$ debuild -S -k'387AFF02'
```

#### Let Upload To LaunchPad:

```bash
^_^[Mitesh@Shah:~]$ dput ppa:rtcamp/nginx ~/PPA/nginx/nginx_1.6.1-1ppa~trusty_source.changes
```
