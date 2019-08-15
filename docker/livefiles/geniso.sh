#/bin/bash

render_template() {
eval "cat <<EOF
$(<$1)
EOF
"
}

geniso() {
cd /custom-live-iso
sed -i "s/^#define DISKNAME.*/#define $DISKNAME/g" README.diskdefines
echo "$DISKNAME" > .disk/info
KSCLABEL=$2
KSDEFAULT=$1
#grub
render_template boot/grub/grub.cfg.templ > boot/grub/grub.cfg

for j in 0 ; do
    KSLABEL=${kslabels[$j]}
    render_template boot/grub/grub.templ >> boot/grub/grub.cfg
done

#isolinux
echo >isolinux/txt.cfg
for j in 0 ; do
    KSLABEL=${kslabels[$j]}
    render_template isolinux/txt.templ >> isolinux/txt.cfg
    if [ "$KSCLABEL" == "${KSLABEL}" ]
    then
	echo "  menu default" >> isolinux/txt.cfg
    fi
done

find . -type f -print0 | xargs -0 md5sum | grep -v "\./md5sum.txt" > md5sum.txt
xorriso -as mkisofs -r -V "$VLABEL" -cache-inodes -J -l -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin -c isolinux/boot.cat -b isolinux/isolinux.bin  -no-emul-boot -boot-load-size 4  -boot-info-table -eltorito-alt-boot  -e boot/grub/efi.img  -no-emul-boot -isohybrid-gpt-basdat -o "/isos/ks-${KSCLABEL}.iso" .
}

VLABEL=vlabel
DISKNAME=smlks

mksquashfs "/work/chroot/" "/custom-live-iso/casper/filesystem.squashfs" -noappend -comp xz
du --summarize --one-file-system --block-size=1 "/work/chroot/" | awk '{print $1}' > /custom-live-iso/casper/filesystem.size
cp /work/chroot/initrd.img /custom-live-iso/casper/initrd
cp /work/chroot/vmlinuz /custom-live-iso/casper/vmlinuz

kslabels=( prod )

for i in 0 ; do
    geniso $i ${kslabels[$i]}
done
