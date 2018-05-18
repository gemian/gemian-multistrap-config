#!/bin/sh

#pass path to the root. Don't let it run without one as it will break your system
if [ "" = "$1" ] ; then
  echo "You need to specify a path to the target rootfs"
else
  if [ -e "$1" ] ; then
    ROOTFS="$1"
  else
    echo "Root dir $ROOTFS not found"
  fi
fi

sudo mount -o rbind /proc $ROOTFS/proc
sudo mount -o rbind /dev $ROOTFS/dev
sudo mount -o rbind /sys $ROOTFS/sys
sudo mount -o tmpfs $ROOTFS/var/cache
sudo mount none -o tmpfs $ROOTFS/var/cache
sudo mount none -t tmpfs $ROOTFS/var/cache
sudo mount none -t tmpfs $ROOTFS/var/run
sudo mount none -t tmpfs $ROOTFS/tmp
sudo mount none -t tmpfs $ROOTFS/root
sudo mount none -t tmpfs $ROOTFS/var/log
