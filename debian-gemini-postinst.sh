ROOTFS=/.stowaways/stretch

#if on gemini pda
mkdir -p $ROOTFS/data/
cp /data/system.img $ROOTFS/data/
#if not change to where ever you've downloaded and uncompressed the latest system.*.img.xz, from https://gemian.thinkglobally.org/system/

./debian-gemini-setup.sh $ROOTFS
chroot $ROOTFS dpkg --configure -a

cp -rv configs/* $ROOTFS

cp debian-gemini-config.sh $ROOTFS/config.sh
chroot $ROOTFS /config.sh
rm $ROOTFS/config.sh

umount -l $ROOTFS/proc
umount -l $ROOTFS/dev/pts
umount -l $ROOTFS/dev
umount -l $ROOTFS/sys
umount -l $ROOTFS/var/cache
umount -l $ROOTFS/var/run
umount -l $ROOTFS/tmp
umount -l $ROOTFS/root
umount -l $ROOTFS/var/log
