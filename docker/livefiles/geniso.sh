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
LIVECLABEL=$2
LIVEDEFAULT=$1
#grub
render_template boot/grub/grub.cfg.templ > boot/grub/grub.cfg

# menuentries
for j in 0 1 ; do
    LIVELABEL=${livelabels[$j]}
    render_template boot/grub/grub.templ >> boot/grub/grub.cfg
done


find . -type f -print0 | xargs -0 md5sum | grep -v "\./md5sum.txt" > md5sum.txt
xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "$VLABEL-$LIVECLABEL" \
    -eltorito-boot \
        boot/grub/bios.img \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        --eltorito-catalog boot/grub/boot.cat \
    --grub2-boot-info \
    --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
 -eltorito-alt-boot \
 -e boot/grub/efi.img \
 -no-emul-boot \
 -isohybrid-gpt-basdat \
 -o "/isos/live-${LIVECLABEL}.iso" .

}

VLABEL=livecd
DISKNAME=live-base

livelabels=(dev prod)

# iso-versions
for i in 0 1 ; do
    geniso $i ${livelabels[$i]}
done
