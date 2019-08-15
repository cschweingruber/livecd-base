# livecd-base
Generator for livecds (ubuntu based)

# Buildscripts für die ISOs auf Dockerbasis

Anleitung zum Builden:
* cd docker
* docker build -t disknameiso:latest .
* docker run -it --name disknameiso ksiso
* docker cp disknameiso:/isos .
 
## Kurzbeschreibung
* Es wird zuerst ein ubuntu:bionic System mit allen notwendigen Tools vorbereitet:
    * debbootstrap
    * iso creation 

* Debbootstrap erzeugt das KS-System im chroot /work/chroot auch dies geschieht in 2 Stufen

* Das ks-system wird mit dem Script prepiso.sh weiter vorbereitet:
    * installation weiterer Pakete (5er Kernel)
    * generierung der initrd

* Das ISO Verzeichnis /custom-live-iso
    * wird mit den vorbereiteten Bootloadern isolinux und grub (für UEFI) ausgerüstet

* geniso.sh generiert ISO-files
    * Sie liegen in /isos
