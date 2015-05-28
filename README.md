# Nginx Debian Package build script

To build Nginx we can use one of the from following two services

1. Launchpad
2. openSuse build services

# Launchpad:

## Create/Verify Account:

Create Account: https://launchpad.net/+login

> The site Launchpad requires that you verify your email address before accessing its contents.

Check your INBOX and click on link to verify.




### Generate GPG/PGP Keys:
```bash
^_^[Mitesh@Shah:~]$ gpg --gen-key

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1

RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096

Please specify how long the key should be valid.
         0 = key does not expire
        = key expires in n days
      w = key expires in n weeks
      m = key expires in n months
      y = key expires in n years
Key is valid for? (0) 0

Key does not expire at all
Is this correct? (y/N) y

Real name: Mitesh Shah
Email address: Mr.Miteshah@gmail.com
Comment: rtCamp Launchpad

You selected this USER-ID:
    "Mitesh Shah (rtCamp Launchpad) <Mr.Miteshah@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

generator a better chance to gain enough entropy.

Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 281 more bytes)
```

Just open another terminal window and run some commands which generates plenty of activity.

My favorite is running a disk write performance benchmark using:

```bash
dd bs=1M count=1024 if=/dev/zero of=test conv=fdatasync
```

### List Keys:

```bash
^_^[Mitesh@Shah:~]$ gpg --list-keys
/home/mitesh/.gnupg/pubring.gpg
------------------------
pub   4096R/387AFF02 2014-04-21
uid                  Mitesh Shah (rtCamp Launchpad) <Mr.Miteshah@gmail.com>
sub   4096R/0B9C8B2D 2014-04-21
```

### Making An ASCII Armored Version Your Public Key:

```bash
^_^[Mitesh@Shah:~]$ gpg --output MiteshShah.asc --export -a $GPGKEY
```

NOTE: In This Example $GPGKEY = 387AFF02


### Upload Keys To Ubuntu Key Server:

```bash
^_^[Mitesh@Shah:~]$ gpg --send-keys --keyserver keyserver.ubuntu.com $GPGKEY
```

### GPG Key FingerPrint:

```bash
^_^[Mitesh@Shah:~]$ gpg --fingerprint
/home/mitesh/.gnupg/pubring.gpg
------------------------
pub   4096R/387AFF02 2014-04-21
      Key fingerprint = 80D6 A2F6 AA2F E34F 0E3A  C850 0E18 6538 387A FF02
uid                  Mitesh Shah (rtCamp Launchpad) <Mr.Miteshah@gmail.com>
sub   4096R/0B9C8B2D 2014-04-21
```

### Add GPG/PGP Keys To LaunchPad:

1. https://launchpad.net/people/+me/+editpgpkeys
1. Sign The Code Of Conduct
1. Create A LaunchPad PPA: nginx


# openSuse build services:

## Create/Verify account:
Create account using Sign Up Link at: https://build.opensuse.org/

After that check you INBOX and click of verification link

## Create Project under account

To create a home project, do following steps:

1. create on your profile name
2. After that click on Home Project on uppper right corner
3. and Click on Create project

## Create Packages

To create package under your project:,
1. Click on package create package
2. Fill the package discription and save changes

## Define Build targets

To build package for specific distros you need to define build targets
1. Click on build targets
2. Then after that define your build targets and click on "Add selected repositories"
