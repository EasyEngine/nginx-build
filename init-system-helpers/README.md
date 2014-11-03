#### Download ppa.sh

```bash
^_^[Mitesh@Shah:~]$ wget -c https://raw.githubusercontent.com/rtCamp/launchpad/master/ppa.sh
```

#### Execute ppa.sh

```bash
^_^[Mitesh@Shah:~]$ bash ppa.sh init-system-helpers
```

## init-system-helpers package
##### Modify Changelog

```bash
^_^[Mitesh@Shah:~]$ vim ~/PPA/init-system-helpers/init-system-helpers-1.7/debian/changelog
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
^_^[Mitesh@Shah:~]$ dput ppa:rtcamp/nginx ~/PPA/init-system-helpers/init-system-helpers_1.7~1ppa~precise_source.changes
```
