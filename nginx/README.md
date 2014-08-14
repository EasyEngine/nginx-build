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

  * Added HTTP Subs Module in nginx-custom package.

 -- Mitesh Shah <Mr.Miteshah@gmail.com>   Thu, 14 Aug 2014 02:51:39 -0700

```

#### Copy Changelog to News.debian
```bash
^_^[Mitesh@Shah:~]$ cp -v ~/PPA/nginx/nginx-1.6.1/debian/changelog ~/PPA/nginx/nginx-1.6.1/debian/News.debian
```

#### Make A Debian Source For Upload To PPA:
```bash
^_^[Mitesh@Shah:~]$ cd ~/PPA/nginx/nginx-1.6.1
^_^[Mitesh@Shah:~]$ debuild -S -k'387AFF02'
```

#### Let Upload To LaunchPad:
```bash
^_^[Mitesh@Shah:~]$ dput ppa:rtcamp/nginx ~/PPA/nginx/nginx_1.6.1-1ppa~trusty_source.changes
```
