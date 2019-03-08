# gemian-multistrap-config
Configs and scripts used to create Debian rootfs for Gemini PDA

## Example usage
On device you can create a stowaway for another flavour of debian, this branch is for buster.

```
sudo multistrap -d /.stowaways/debian/ -f debian-gemini.conf
```

On the device there seems to be a problem setting up ssh, so its best to remove that from the first run of the above command (editing the config file first).

You also need to edit debian-gemini-postinst.sh to point to your stowaway root fs and run that (if not on device don't forget to swap in the location of the android system.img).
```
sudo ./debian-gemini-postinst.sh
```

You will also need a stowaway kernel to boot the new folder:
```
wget https://gemian.thinkglobally.org/linux-boot-2018-06-06-stowaways-debian.img
sudo dd if=linux-boot-2018-06-06-stowaways-debian.img of=/dev/disk/by-partlabel/linux_boot
```

If you want to make an image file for distribution:
```
sudo truncate -s 2G stretch.img
sudo mkdir stretch
sudo mkfs.ext4 -q stretch.img
sudo mount stretch.img stretch

```
