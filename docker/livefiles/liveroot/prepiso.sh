ln -s /bin/true /sbin/initctl
export HOME=/root
export LC_ALL=C
apt-get update
apt-get install --yes dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
apt-get upgrade
apt-get install --yes ubuntu-standard linux-virtual-hwe-18.04 casper lupin-casper jq git mc curl network-manager
update-initramfs -u -k all
