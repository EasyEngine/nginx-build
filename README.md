Nginx Build
==========

### Facts as of now

1. The following repo contains all the files necessary to package and build
the Custom Nginx used by EasyEngine(Public).
https://github.com/EasyEngine/launchpad
2. This does not contain anything https://github.com/EasyEngine/nginx-build
3. This contains everything related to the latest build of
nginx(not yet released) http://git.rtcamp.com/sys/nginx-build

### What do we want in the process

1. A final repo that contains everything
https://github.com/EasyEngine/nginx-build
2. The following Docker Image contains every tool that will be required during
the packaging process and to interact with the openSUSE Build Service.
https://hub.docker.com/r/rtcamp/nginx-build/



## The Process

**WARNING:** *Before starting go through the links at the bottom of this
document.*

1. Start the container.
```bash
mkdir ~/nginx-build
cd ~/nginx-build
docker run --name=nginx-build -dit -v $PWD:/root/data rtcamp/nginx-build bash
```

2. Copy the GPG keys(both public and private) to `~/nginx-build`.
(Contact @rahul286 for GPG keys).

3. Enter the container.
```bash
docker exec -it nginx-build bash
```
4. Import the keys
```bash
cd /root/data/
gpg --import public.key
gpg --import --allow-secret-key-import private.key
```

5. Clone the repo.
```bash
git clone https://github.com/EasyEngine/nginx-build
cd nginx-build
```

6. Set **your name** as the Package Maintainer.
```bash
export DEBFULLNAME="Mriyam Tamuli"
```

7. Run the script with the _latest **stable** release_ and **your email id**.
```bash
bash ppa.sh nginx 1.10.3 mbtamuli@gmail.com
```

8. At the end of the script’s run, you will find the **CHANGELOG** open in vim.

    ```
    nginx (1.10.3-2ppa~stable) stable; urgency=high

    * Update version to 1.10.3

    -- Mriyam Tamuli <mbtamuli@gmail.com>  Sat, 04 Feb 2017 03:05:53 +0530
    ```
    This revision number of the build in bold has to be changed to build it
    successfully.  
    (1.10.3-**2**ppa~stable)  
    This will download the latest Nginx source, the modules from their respective
    Github links, modify the changelog and create the whole directory structure at
    `~/PPA/nginx`

9. Go to the nginx directory (check the latest version)
```bash
cd ~/PPA/nginx/nginx-1.10.3
```

10. Start the packaging
```bash
debuild -S -sa -k'C3AA4041'
```
You will be asked for a password. Get the password for the GPG key.

11. Checkout the repository.
```bash
cd ~
osc co home:mbtamuli:EasyEngine
```

12. Remove the current files from the nginx repo.
```bash
cd home:mbtamuli:EasyEngine/nginx
osc rm *
```

13. The files that need to be uploaded will be generated in the `~/PPA/nginx`
directory. Only the files you already see [here]
(https://build.opensuse.org/package/show/home:rtCamp:EasyEngine/nginx)
will be necessary.  
Copy the files from `~/PPA/nginx` to `~/home:rtCamp:EasyEngine`.
```bash
rsync -avzP --exclude="modules" --exclude="nginx-1.10.3" ~/PPA/nginx ~/home:mbtamuli:EasyEngine/nginx/
```

14. Add the new files to the repo.
```bash
osc add *
```

15. Commit and push the changes.
```bash
osc ci -m “Revision message describing any changes”
```

17. Pat yourself on the back for a job well done. :)

## Reference

* https://www.debian.org/doc/manuals/maint-guide/build.en.html
* https://www.debian.org/doc/manuals/maint-guide/update.en.html#newupstream
* https://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog
* https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
