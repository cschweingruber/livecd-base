#/bin/bash
mkdir /isos
mksquashfs "/work/chroot/" "/custom-live-iso/casper/filesystem.squashfs" -noappend -comp xz
du --summarize --one-file-system --block-size=1 "/work/chroot/" | awk '{print $1}' > /custom-live-iso/casper/filesystem.size
cp /work/chroot/initrd.img /custom-live-iso/casper/initrd
cp /work/chroot/vmlinuz /custom-live-iso/casper/vmlinuz
