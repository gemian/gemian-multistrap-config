ROOTFS=gemian-rootfs

./debian-gemini-chroot.sh $ROOTFS
chroot $ROOTFS dpkg --configure -a

cp -rv configs/* $ROOTFS

cp debian-gemini-config.sh $ROOTFS/config.sh
chroot $ROOTFS /config.sh
rm $ROOTFS /config.sh

umount -lR $ROOTFS/proc/
umount -lR $ROOTFS/dev
umount -lR $ROOTFS/sys
umount -l $ROOTFS/var/cache/
umount -l $ROOTFS/var/cache/
umount -l $ROOTFS/var/cache/
umount -l $ROOTFS/var/run
umount -l $ROOTFS/tmp/
umount -l $ROOTFS/root/
umount -l $ROOTFS/var/log/
