#/bin/bash
cp -a /liveroot/root/. /work/chroot/root
cp -a /liveroot/etc/. /work/chroot/etc
mv /finalize.sh /work/chroot
chroot /work/chroot /finalize.sh
cd /work/chroot
mv filesystem.manifest /custom-live-iso/casper
rm prepiso.sh
rm finalize.sh
rm boot/*.old
exit 0
