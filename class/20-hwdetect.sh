#! /bin/bash

# (c) Thomas Lange, 2002-2013, lange@informatik.uni-koeln.de

# NOTE: Files named *.sh will be evaluated, but their output ignored.

[ $do_init_tasks -eq 1 ] || return 0 # Do only execute when doing install

echo 0 > /proc/sys/kernel/printk

#kernelmodules=
# here, you can load modules depending on the kernel version
case $(uname -r) in
    2.6*) kernelmodules="$kernelmodules mptspi dm-mod md-mod aes dm-crypt" ;;
    [3456]*) kernelmodules="$kernelmodules mptspi dm-mod md-mod aes dm-crypt" ;;
esac

for mod in $kernelmodules ; do
    [ X$verbose = X1 ] && echo Loading kernel module $mod
    modprobe -a $mod 1>/dev/null 2>&1
done

echo 6 > /proc/sys/kernel/printk

set_disk_info  # recalculate list of available disks
save_dmesg     # save new boot messages (from loading modules)

