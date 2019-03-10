# gemian-multistrap-config
Configs and scripts used to create Debian rootfs for Gemini PDA

## Example usage
On device you can create a stowaway for another flavour of debian, eg swap stretch for buster in debian-gemini.conf, see buster branch
```
sudo multistrap -d ./gemian-rootfs/ -f debian-gemini.conf
```
You will get lots of errors, so long as the downloading of the packages and a bash at setting them up happens you can proceed to the next step to finish off the process.

You also need to edit debian-gemini-postinst.sh to point to your stowaway root fs and run that (if not on device don't forget to swap in the location of the android system.img).
```
sudo ./debian-gemini-postinst.sh
```

If you want to make an image file for distribution best to use a new LVM volume, possibly on an external SD Card/USB Memory Stick:
```
sudo lvcreate -n gemian-rootfs -L 4G planetlinux
sudo mkfs.ext4 /dev/planetlinux/gemian-rootfs
mkdir gemian-rootfs
sudo mount /dev/planetlinux/gemian-rootfs ./gemian-rootfs/
```
Make file system with multistrap+postinst scripts above.
```
sudo umount ./gemian-rootfs/
sudo lvm lvresize --resizefs --size 2.8G /dev/planetlinux/stretch
sudo dd if=/dev/planetlinux/gemian-rootfs of=gemian-rootfs.img
```
Possibly copy image to a faster computer with the ethernet adapter plugged in:
```
scp geminipda:gemian-rootfs.img .
e2fsck -f gemian-rootfs.img
resize2fs -M gemian-rootfs.img
xz -z gemian-rootfs.img
```
