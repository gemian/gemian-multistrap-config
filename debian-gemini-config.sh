#!/bin/sh
mkdir /nvcfg
mkdir /nvdata
mkdir /system
mkdir /data
ln -s system/vendor /vendor

systemctl enable usb-tethering
systemctl enable ssh

systemctl enable system.mount
systemctl enable tmp.mount
systemctl enable android-mount.service
systemctl enable droid-hal-init
systemctl enable lxc@android.service

systemctl disable isc-dhcp-server.service  isc-dhcp-server6.service lxc-net.service ureadahead.service systemd-modules-load.service
systemctl disable connman-wait-online.service

echo "nameserver 8.8.8.8" > /etc/resolv.conf
wget -O - http://gemian.thinkglobally.org/archive-key.asc | sudo apt-key add -

update-alternatives --set aarch64-linux-gnu_egl_conf /usr/lib/aarch64-linux-gnu/libhybris-egl/ld.so.conf
mkdir /usr/lib/aarch64-linux-gnu/mesa-egl
mv /usr/lib/aarch64-linux-gnu/libGLESv* /usr/lib/aarch64-linux-gnu/libEGL.so* /usr/lib/aarch64-linux-gnu/mesa-egl

ldconfig

# PulseAudio
# /etc/pulseaudio/default.pa

groupadd -g 1000 aid_system
groupadd -g 1003 aid_graphics
groupadd -g 1004 aid_input
groupadd -g 1005 aid_audio
groupadd -g 3001 aid_net_bt_admin
groupadd -g 3002 aid_net_bt
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_inet_raw
groupadd -g 3005 aid_inet_admin
groupadd -g 100000 gemini

useradd -m -u 100000 -g 100000 -G audio,video,sudo,aid_system,aid_graphics,aid_input,aid_audio,aid_net_bt_admin,aid_net_bt,aid_inet,aid_inet_raw,aid_inet_admin -s /bin/bash gemini

echo "gemini:gemini" | chpasswd

ln -sf ../lib/systemd/systemd /sbin/init

# Hack for chromium
mkdir -p /usr/lib/chromium
ln -sf /usr/lib/aarch64-linux-gnu/libhybris-egl/libEGL.so.1.0.0 /usr/lib/chromium/libEGL.so
ln -sf /usr/lib/aarch64-linux-gnu/libhybris-egl/libGLESv2.so.2.0.0 /usr/lib/chromium/libGLESv2.so
