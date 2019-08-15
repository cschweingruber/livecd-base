#/bin/bash
cp -a /liveroot/root/. /work/chroot/root
cp -a /liveroot/etc/. /work/chroot/etc
mv /checkoutks.sh /work/chroot
chroot /work/chroot /checkoutks.sh
cd /work/chroot
mv filesystem.manifest /custom-live-iso/casper
rm prepiso.sh
rm checkoutks.sh
rm *.old
