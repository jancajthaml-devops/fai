### broken things

---

The following packages will be REMOVED:
  systemd-sysv 
The following packages are RECOMMENDED but will NOT be installed:
  binutils bzip2 console-setup cryptsetup curl dmraid krb5-locales libfile-fcntllock-perl libglib2.0-data libgraph-perl libsasl2-modules lvm2 mdadm nbd-client open-iscsi pigz python shared-mime-info syslinux-common xdg-user-dirs xz-utils 
0 packages upgraded, 48 newly installed, 1 to remove and 2 not upgraded.
Need to get 14.3 MB of archives. After unpacking 69.8 MB will be used.
The following packages have unmet dependencies:
 init : PreDepends: systemd-sysv but it is not going to be installed or
                    sysvinit-core but it is not going to be installed or
                    runit-init but it is not going to be installed
The following actions will resolve these dependencies:

     Install the following packages:  
1)     initscripts [2.93-8 (stable)]  
2)     insserv [1.18.0-2 (stable)]    
3)     startpar [0.61-1 (stable)]     
4)     sysv-rc [2.93-8 (stable)]      
5)     sysvinit-core [2.93-8 (stable)]

---

Unpacking initscripts (2.93-8) ...
dpkg: systemd-sysv: dependency problems, but removing anyway as you requested:
 init depends on systemd-sysv | sysvinit-core | runit-init; however:
  Package systemd-sysv is to be removed.
  Package sysvinit-core is not installed.
  Package runit-init is not installed.

---

insserv: warning: script 'rcS.distrib' missing LSB tags
insserv: Default-Start undefined, assuming empty start runlevel(s) for script `rcS.distrib'
insserv: Default-Stop  undefined, assuming empty stop  runlevel(s) for script `rcS.distrib'
insserv: warning: script 'rcS.distrib' missing LSB tags

---

dracut: WARNING: <key>+=" <values> ": <values> should have surrounding white spaces!
dracut: WARNING: This will lead to unwanted side effects! Please fix the configuration file.

dracut: dracut module 'livenet' cannot be found or installed.

---