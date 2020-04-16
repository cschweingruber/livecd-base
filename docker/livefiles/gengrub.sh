#/bin/bash
# generate bios.img
grub-mkstandalone  \
   --format=i386-pc \
   --output=/bootloader/core.img \
   --install-modules="linux normal iso9660 biosdisk memdisk search tar ls configfile cat echo" \
   --modules="linux normal iso9660 biosdisk search configfile cat echo" \
   --locales="" \
   --fonts="" \
   "boot/grub/grub.cfg=/bootloader/grub-bios.cfg"
cat /usr/lib/grub/i386-pc/cdboot.img /bootloader/core.img > /bootloader/bios.img

#generate efi-64
#grub-mkstandalone -v \
#    --format=x86_64-efi \
#    --output=/bootloader/bootx64.efi \
#    --locales="" \
#    --fonts="" \
#    "boot/grub/grub.cfg=/bootloader/scratch/grub.cfg"

# get signed uefi from ubuntu-mini.iso
cd /
wget -nv http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso
cd /custom-live-iso
7z x -r /mini.iso boot
# not needed
#mcopy -i boot/grub/efi.img -spm ::efi .
rm /mini.iso
chmod 755 /custom-live-iso/boot/grub/x86_64-efi
cp /bootloader/bios.img /custom-live-iso/boot/grub/bios.img
cp -a /usr/lib/grub/i386-pc /custom-live-iso/boot/grub/
cp /bootloader/boot/grub/grub* /custom-live-iso/boot/grub/
