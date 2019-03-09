# gemian-multistrap-config
Configs and scripts used to create Debian rootfs for Gemini PDA

## Example usage
On device you can create a stowaway for another flavour of debian, eg swap stretch for buster in debian-gemini.conf, see buster branch
```
sudo multistrap -d /.stowaways/stretch/ -f debian-gemini.conf
```
You will get lots of errors, so long as the downloading of the packages and a bash at setting them up happens you can proceed to the next step to finish off the process.

You also need to edit debian-gemini-postinst.sh to point to your stowaway root fs and run that (if not on device don't forget to swap in the location of the android system.img).
```
sudo ./debian-gemini-postinst.sh
```

If you want to make an image file for distribution (sparse file is used so actual disk space should be ~2-3G):
```
sudo truncate -s 5G stretch.img
sudo mkdir stretch
sudo mkfs.ext4 -q stretch.img
sudo mount stretch.img stretch
sudo cp -r /.stowaways/stretch/* ./stretch/
sudo umount ./stretch/
```
Ideally you would then run simg2img over the image to help reduce its size:
```
simg2img stretch.img stretch.img.raw
mv stretch.img.raw stretch.img
```
Then shrink and compress the image:
```
e2fsck -f stretch.img
resize2fs -M stretch.img
xz -z stretch.img
```
