# gemian-multistrap-config
Configs and scripts used to create Debian rootfs for Gemini PDA

## Example usage
On device you can create a stowaway for another flavour of debian, eg swap stretch for buster in debian-gemini.conf
```
sudo multistrap -d /.stowaways/debian-pm/ -f debian-gemini.conf
```
On the device there seems to be a problem setting up ssh, so its best to remove that from the first run of the above command (editing the config file first).

You also need to edit debian-gemini-postinst.sh to point to your stowaway root fs and run that (if not on device don't forget to swap in the location of the android system.img).
```
sudo ./debian-gemini-postinst.sh
```
